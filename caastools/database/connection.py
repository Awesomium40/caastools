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
        self._connection.execute(TBL_SCRIPT)
        self._connection.commit()

    def __del__(self):
        self._connection.close()

    def close(self):
        self._connection.close()

    @staticmethod
    def vn_validate(var_name):
        return _Connection._vn_re.fullmatch(var_name) is not None
