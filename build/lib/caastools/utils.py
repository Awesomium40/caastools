import re
import logging


__all__ = ['multi_replace', 'sanitize_for_spss']


logging.getLogger('utils').addHandler(logging.NullHandler())


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


def multi_replace(txt, find, repl, ignore_case=False, whole_word_only=False):
    """
    caastools.utils.multi_replace(text, repl, ignore_case=False, whole_word_only=False) -> str
    Performs simultaneous multi-replacement of substrings within a string
    :param txt: string in which replacements are to be performed
    :param find: sequence of strings for which replacments are to be made
    :param repl: sequence of strings with with to replace corresponding entry in find, or a function
    which achieves the same result
    which achieves the same
    :param ignore_case: specifies whether to ignore case in search/replacement. Default False
    :param whole_word_only: specifies whether to replace only on whole word matches. Default False
    :return: string with replacements made
    """

    repl_str = "{0}{{0}}{0}".format("\\b" if whole_word_only else '')

    # The problem is that there is the risk of having one replacement be
    # the substring of another. Deal with this issue by sorting long to short
    replacements = sorted(find, key=len, reverse=True)
    replace_re = re.compile("|".join(map(lambda x: repl_str.format(re.escape(x)), replacements)),
                            re.IGNORECASE if ignore_case else 0)

    if callable(repl):
        result = replace_re.sub(repl, txt)
    else:
        if len(repl) < len(find):
            raise ValueError("each entry in 'find' must have a corresponding entry in 'repl'")

        repl_dict = {f: r for f, r in zip(find, repl)}
        result = replace_re.sub(lambda match: repl_dict[match.group(0)], txt)

    return result


@_static_vars_(counter=0)
def sanitize_for_spss(dirty_str, find=None, repl=None):
    """
    sanitize_for_spss(str, subs={}) -> str
    Sanitizes the provided string into an SPSS-Compatible identifier
    :param dirty_str: the string to be sanitized
    :param find: A sequence of substrings to be replaced in the sanitized string. Default None
    Note that using unsanitary values will cause custom substitutions to themselves be sanitized.
    :param repl: A sequence of replacements for corresponding entries in find, or a function that generates replacements
    Default None
    :return: str
    :raise ValueError: if either find/repl is None and the other is not None
    :raise ValueError: if find and repl are sequences of unequal length
    """

    if (find is None) ^ (repl is None):
        raise ValueError("if one of parameters (find, repl) are specified, both must be specified")
    if not callable(repl) and len(find) != len(repl):
        raise ValueError("parameters find and repl must be of same length")

    # SPSS has specifications on variable names. These will help ensure they are met
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

    # If any custom substitutions are required, perform prior to final sanitization
    if len(find) > 0:
        new_var = multi_replace(new_var, find, repl)

    # locate invalid characters and replace with underscores
    invalid_find = invalid_chars.findall(new_var)
    invalid_repl = ["_" for x in invalid_find]

    new_var = multi_replace(new_var, invalid_find, invalid_repl) if len(invalid_find) > 0 else new_var

    # Trim off excess characters to fit into maximum allowable length
    new_var = new_var[:32] if len(new_var) > max_length else new_var

    return new_var







