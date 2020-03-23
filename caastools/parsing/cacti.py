import functools
import operator

__all__ = ['read_casaa', 'read_globals']


def read_globals(path_to_globals, slices=None):
    """
    make_globals(globalPath, sePath, parser, coding_system) -> list[tuple[str, int]]
    Parses the globals file at path_to_globals and returns a dict mapping global names to values
    :param path_to_globals: the path to the MISC globals file
    :param slices: sequence of slices representing the lines of data to be read as data. Default None (read whole file)
    :return: list of tuples. First entry is global name, second entry is global score
    """

    global_data = []
    with open(path_to_globals, 'r') as in_file:
        global_txt = in_file.readlines()
        # The globals of interest are stored in different locations in each file (5-11 for MISC)

    to_process = functools.reduce(operator.concat, (global_txt[s] for s in slices))

    for line in to_process:
        split_line = [itm.strip(":").strip("\n") for itm in line.split("\t")]
        global_data.append(tuple((split_line[0], split_line[1])))

    return global_data


def read_casaa(path):
    """
    _read_casaa_text_(path) -> list[tuple]:
    reads the .casaa file specified at path and returns a list of rows found in the file
    :param path: the path to the casaa file
    """

    def bit_to_time(bit_stamp):
        channels = 2
        sample_rate = 44100
        bit_rate = 2
        bps = channels * sample_rate * bit_rate

        return (int(bit_stamp) - 44) / bps

    row_data = []
    with open(path, 'r') as in_file:
        for row in in_file.readlines()[1:]:
            if len(row.strip('\n').strip('\t')) == 0: continue

            split_row = row.strip('\n').split('\t')
            if len(split_row) < 5:
                raise ValueError("Unable to read casaa data at {0}: Too few columns".format(path))

            row_data.append(
                (int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]))
                if len(split_row) == 5 else
                (int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), split_row[5])
                if len(split_row) == 6 else
                (int(split_row[0]), bit_to_time(split_row[3]), bit_to_time(split_row[4]), split_row[5], split_row[6]))

    return row_data
