import functools
import logging
import operator

logging.getLogger('caastools.parsing.cacti.data').addHandler(logging.NullHandler())


def _read_file_(file):
    """
    Attempts to read lines of text from file
    :param file: file-like object or path to file
    :return: list[str]
    """

    try:
        row_data = file.readlines()
    except AttributeError as err:
        with open(file, 'r') as in_file:
            row_data = file.readlines

    return row_data


def read_globals(file, slices=None):
    """
    make_globals(globalPath, sePath, parser, coding_system) -> list[tuple[str, int]]
    Parses the globals file at path_to_globals and returns a dict mapping global names to values
    :param file: a file-like object with the MISC globals, or the path to the MISC globals file
    :param slices: sequence of slices representing the lines of data to be read as data. Default None (read whole file)
    :return: list of tuples. First entry is global name, second entry is global score
    """

    global_data = []
    slices = [slice(0)] if slices is None else slices
    global_txt = _read_file_(file)

    # The globals of interest are stored in different locations in each file (5-11 for MISC)
    to_process = functools.reduce(operator.concat, (global_txt[s] for s in slices)) \
        if slices is not None else global_txt

    for line in to_process:
        split_line = [itm.strip(":").strip("\n") for itm in line.split("\t")]
        global_data.append((split_line[0], split_line[1]),)

    return global_data


def read_casaa(file, read_codes=False, read_components=False):
    """
    _read_casaa_text_(path) -> list[tuple]:
    reads the .casaa file specified at path and returns a list of rows found in the file
    :param file: a file-like object holding the casaa data, or the path to the casaa file
    :param read_codes: Whether to read coding data (True) or to ignore any codes (False). Default False
    :param read_components: Whether to attempt to read component data. Overridden by setting ignore_codes to True
    """

    def bit_to_time(bit_stamp):
        channels = 2
        sample_rate = 44100
        bit_rate = 2
        bps = channels * sample_rate * bit_rate

        return (int(bit_stamp) - 44) / bps

    row_data = []
    for i, row in enumerate(_read_file_(file)):
        if len(row.strip('\n').strip('\t')) == 0: continue
        split_row = row.strip('\n').split('\t')
        if len(split_row) < 5:
            raise ValueError("Unable to read casaa data from file: Too few columns")

        if read_codes:
            # Expect 7 columns for reading in codes. If less than that found, enter None for value and desc
            if len(split_row) == 7:
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]),
                                split_row[5], split_row[6],))
            else:
                logging.warning(f"Line {i} of file expected 7 columns, found {len(split_row)}. " +
                                "Code data will not be read")
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), None, None,))

        elif read_components:
            # Expect 6 columns for reading in components. Anything else, enter None for value and desc
            if len(split_row == 6):
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), split_row[5],))
            else:
                logging.warning(f"Line {i} of file expected 7 columns, found {len(split_row)}. " +
                                "Component data will not be read")
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), None,))
        else:
            row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]),))

    return row_data
