import logging
from caastools.database.connection import _Connection


connection: _Connection = None
__all__ = ['close_database', 'connection', 'init_database', 'get_connection']

logging.getLogger('database').addHandler(logging.NullHandler())


def init_database(path=":memory:"):
    """
    Establish the connecction to the database at path.
    :param path: path to the SQLite database
    :return: None
    """
    global connection
    connection = _Connection(path)


def close_database():
    connection.close()


def get_connection():
    global connection
    return connection
