import re


__all__ = ['multi_replace', 'sanitize_for_spss']


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
def sanitize_for_spss(dirty_str, sub=None):
    """
    sanitize_for_spss(str, subs={}) -> str
    Sanitizes the provided string into an SPSS-Compatible identifier
    :param dirty_str: the string to be sanitized
    :param sub: A dictionary of substitutions to use in the santization process. Keys will be replaced with values
    in the sanitized string. Note that using unsanitary values will cause custom substitutions to themselves be sanitized.
    Default None
    :return: str
    """
    # SPSS has specifications on variable names. These will help ensure they are met
    max_length = 32
    invalid_chars = re.compile(r"[^a-zA-Z0-9_.]")
    invalid_starts = re.compile(r"[^a-zA-Z]+")
    subs = {} if sub is None else sub

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







