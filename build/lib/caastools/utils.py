import re
import pandas
import pandas.api.types as ptypes
from savReaderWriter.savWriter import SavWriter

__all__ = ['multi_replace', 'sanitize_for_spss', 'save_as_spss']


def _static_vars_(**kwargs):
    """
    Adds static variables to a decorated function
    Code taken from https://stackoverflow.com/questions/279561/
    what-is-the-python-equivalent-of-static-variables-inside-a-function
    :param kwargs:
    :return:
    """
    def decorate(func):
        for k in kwargs:
            setattr(func, k, kwargs[k])
        return func
    return decorate


def multi_replace(txt, repl, ignore_case=False, whole_word_only=False):
    """
    caastools.utils.multi_replace(text, repl, ignore_case=False, whole_word_only=False) -> str
    Performs simultaneous multi-replacement of substrings within a string
    :param txt: string in which replacements are to be performed
    :param repl: dictionary mapping substrings to be replaced with their replacements
    :param ignore_case: specifies whether to ignore case in search/replacement. Default False
    :param whole_word_only: specifies whether to replace only on whole word matches. Default False
    :return: string with replacements made
    """

    repl_str = "{0}{{0}}{0}".format("\\b" if whole_word_only else '')

    # The problem is that there is the risk of having one replacement be
    # the substring of another. Deal with this issue by sorting long to short
    replacements = sorted(repl, key=len, reverse=True)

    # Next, we can just use the regex engine to do the replacements all at once
    # Preferable to iteration because sequential replacement may cause undesired results
    replace_re = re.compile("|".join(map(lambda x: repl_str.format(re.escape(x)), replacements)),
                            re.IGNORECASE if ignore_case else 0)

    return replace_re.sub(lambda match: repl[match.group(0)], txt)


@_static_vars_(counter=0)
def sanitize_for_spss(dirty_str, subs={}):
    """
    sanitize_for_spss(str, subs={}) -> str
    Sanitizes the provided string into an SPSS-Compatible identifier
    :param dirty_str: the string to be sanitized
    :param subs: A dictionary of substitutions to use in the santization process. Keys will be replaced with values
    in the sanitized string. Note that using unsanitary values will cause custom substitutions to themselves be sanitized.
    Default {}
    :return: str
    """
    # SPSS has speicifications on variable names. These will help ensure they are met
    max_length = 32
    invalid_chars = re.compile(r"[^a-zA-Z0-9_.]")
    invalid_starts = re.compile(r"[^a-zA-Z]+")

    # Remove invalid starting characters
    start_invalid = invalid_starts.match(dirty_str)
    new_var = invalid_starts.sub('', dirty_str, count=1) if start_invalid else dirty_str

    # Possible that the process of removing starting chars could create empty string,
    # so create valid var name in that case
    if len(new_var) == 0:
        sanitize_for_spss.counter += 1
        new_var = "VAR_{0}".format(sanitize_for_spss.counter)

    # Trim off excess characters to fit into maximum allowable length
    new_var = new_var[:32] if len(new_var) > max_length else new_var

    # If any custom substitutions are required, perform prior to final sanitization
    if len(subs) > 0:
        new_var = multi_replace(new_var, subs)

    # locate invalid characters and replace with underscores
    replacements = {x: "_" for x in invalid_chars.findall(new_var)}
    new_var = multi_replace(new_var, replacements) if len(replacements) > 0 else new_var

    return new_var


def save_as_spss(data_frame: pandas.DataFrame, out_path: str, var_labels={}) -> None:
    """
    caastools.utils.save_as_spss(data_frame: pandas.DataFrame, out_path: str) -> None
    saves data_frame as an SPSS dataset at out_path
    :param data_frame: the pandas DataFrame to save
    :param out_path: the path at which to save the file
    :param var_labels: a dictionary mapping column labels in the data frame to a variable label in the SPSS dataset
    :return: None
    """

    cols = data_frame.columns  # type: pandas.Index
    is_multi_index = isinstance(cols, pandas.MultiIndex)
    var_names = []
    var_types = {}
    var_formats = {}

    # Construct the various information that the SPSS dictionary will contain about each variable
    for col in cols:
        var_name = sanitize_for_spss(".".join(str(i) for i in col) if is_multi_index else str(col),
                                     subs={"+": "Pos", "-": "Neg"})
        var_names.append(var_name)

        # Need to know the data type and format of each column so that the SPSS file can be written properly
        # 0 is a numeric type, any positive integer is a string type where the number represents the number
        # of bytes the string can hold.
        # TODO: Add in checks for additional dtypes
        if pandas.api.types.is_string_dtype(data_frame[col]):
            var_types[var_name] = max(data_frame[col].str.len()) * 2
        else:
            var_types[var_name] = 0
            var_formats[var_name] = "F10.2" if ptypes.is_float(data_frame[col]) else \
                "ADATE8" if ptypes.is_datetime64_any_dtype(data_frame[col]) else \
                "F12.0"

    # Sometimes savReaderWriter has trouble writing a whole dataframe in at once,
    # Writing row by row seems to work without issue
    with SavWriter(out_path, var_names, var_types, formats=var_formats, varLabels=var_labels, ioUtf8=True) as writer:
        for row in data_frame.index:
            writer.writerow(data_frame.loc[row, :].values)




