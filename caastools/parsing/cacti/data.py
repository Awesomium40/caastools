import logging
import typing
import warnings

logging.captureWarnings(True)
logging.getLogger('py.warnings').addHandler(logging.NullHandler())


def _read_file_(file):
    """
    Attempts to read lines of text from file
    :param file: file-like object or path to file
    :return: list[str]
    """

    try:
        if file.tell() > 0:
            file.seek(0)
    except AttributeError as err:
        with open(file, 'r') as in_file:
            for row in in_file:
                yield row
    else:
        for row in file:
            yield row


def read_globals(file):
    """
    make_globals(globalPath, sePath, parser, coding_system) -> list[tuple[str, int]]
    Parses the globals file at path_to_globals and returns a dict mapping global names to values
    :param file: a file-like object with the MISC globals, or the path to the MISC globals file
    :param slices: sequence of slices representing the lines of data to be read as data. Default None (read whole file)
    :return tuple[str, list[tuple]]: The path to the audio file scored,
    and a list of tuples, each containing the global name and the score given
    :raise ValueError: if data cannot be parsed into its appropriate type
    """

    global_data = []
    global_txt = _read_file_(file)

    # Audio file path is stored on the third line of globals file

    for i, line in enumerate(global_txt):
        if i == 2:
            audio_file = line.strip('\n').split('\t')[1]
            continue
        elif i < 3:
            continue

        split_line = [itm.strip(":").strip("\n") for itm in line.split("\t")]

        # Skip rows that are invalid, warn the user
        if len(split_line) < 2:
            warnings.warn(f"Line {i} expected 2 columns, got {len(split_line)}. Data will be skipped", UserWarning)
            continue

        global_data.append((split_line[0], split_line[1]),)

    return audio_file, global_data


def read_casaa(file, read_codes=False, read_components=False) -> typing.Tuple[str, typing.List[tuple]]:
    """
    read_casaa(path, read_codes=False, read_components=False) -> str, list[tuple]:
    reads the .casaa file specified at path and returns a list of rows found in the file
    :param file: a file-like object holding the casaa data, or the path to the casaa file
    :param read_codes: Whether to read coding data (True) or to ignore any codes (False). Default False
    :param read_components: Whether to attempt to read component data. Overridden by setting read_codes to True
    :return tuple[str, list[tuple]: the path to the audio file to which the casaa file points,
    and a list of the utterance data
    :raise ValueError: If data in file cannot be parsed into its appropriate type
    """

    def bit_to_time(bit_stamp):
        channels = 2
        sample_rate = 44100
        bit_rate = 2
        bps = channels * sample_rate * bit_rate

        return (int(bit_stamp) - 44) / bps

    row_data = []
    audio_file = None
    for i, row in enumerate(_read_file_(file)):
        split_row = row.strip('\n').split('\t')
        if len(split_row) == 0:
            continue

        if i == 0:
            audio_file = split_row[1]
            continue

        if read_codes:
            # Expect 7 columns for reading in codes. If less than that found, enter None for value and desc
            if len(split_row) == 7:
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]),
                                int(split_row[5]), split_row[6],))
            else:
                warnings.warn(f"Line {i} of file expected 7 columns, found {len(split_row)}. " +
                              "Code data will not be read", UserWarning)
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), None, None,))

        elif read_components:
            # Expect 6 columns for reading in components. Anything else, enter None for value and desc
            if len(split_row) == 6:
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), split_row[5],))
            else:
                warnings.warn(f"Line {i} of file expected 7 columns, found {len(split_row)}. " +
                              "Component data will not be read", UserWarning)
                row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), None,))
        else:
            row_data.append((int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]),))

    return audio_file, row_data
