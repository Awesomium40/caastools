from caastools.database.model import TBL_SCRIPT
import logging
import sqlite3


logging.getLogger('database.database').addHandler(logging.NullHandler())

_con = None


def connect(db_path):
    global _con
    pragmas = (('journal_mode', 'wal'),
               ('cache_size', '-64000'),  # 64MB
               ('foreign_keys', 'on'),
               ('ignore_check_constraints', 'off'))
    _con = sqlite3.connect(db_path)
    for key, value in pragmas:
        _con.execute(f"PRAGMA {key}={value};")
    _con.executescript(TBL_SCRIPT)
    _con.commit()
