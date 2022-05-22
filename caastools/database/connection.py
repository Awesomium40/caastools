from caastools.database.model import TBL_SCRIPT
import logging
import re
import sqlite3


logging.getLogger('database.database').addHandler(logging.NullHandler())


class _Connection(object):
    _vn_re = re.compile(r'^[a-zA-Z_][a-zA-Z0-9._]*$')

    def __init__(self, path=':memory:'):
        pragmas = (('journal_mode', 'wal'),
                   ('cache_size', '-64000'),  # 64MB
                   ('foreign_keys', 'on'),
                   ('ignore_check_constraints', 'off'))
        self._connection = sqlite3.connect(path)
        self._connection.create_function('vn_validate', 1, self.vn_validate)
        for key, value in pragmas:
            self._connection.execute(f"PRAGMA {key}={value};")
        self._connection.executescript(TBL_SCRIPT)
        self._connection.commit()

    def __del__(self):
        self._connection.close()

    def close(self):
        self._connection.close()

    def commit(self):
        return self._connection.commit()

    def execute(self, query, args=None):
        return self._connection.execute(query, args) if args is not None else self._connection.execute(query)

    def executemany(self, query, params):
        return self._connection.executemany(query, params)

    def executescript(self, script):
        return self._connection.executescript(script)

    def rollback(self):
        return self._connection.rollback()

    @staticmethod
    def vn_validate(var_name):
        return _Connection._vn_re.fullmatch(var_name) is not None and len(var_name) < 33
