from playhouse.sqlite_ext import SqliteExtDatabase
import logging


logging.getLogger('database.database').addHandler(logging.NullHandler())

__all__ = ['db', 'atomic']


db = SqliteExtDatabase(None)
atomic = db.atomic
