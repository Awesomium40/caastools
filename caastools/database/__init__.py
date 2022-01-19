from caastools.database.database import db, atomic
from caastools.database.model import CodingSystem, CodingProperty, GlobalProperty, GlobalStaging, GlobalRating, \
    GlobalValue, Interview, PropertyValue, Utterance, UtteranceCode, UtteranceStaging, Translation, TranslationSource, \
    TranslationTarget, TranslationSourceRoot
from peewee import OperationalError
import logging


__all__ = __all__ = ['atomic', 'db', 'init_database', 'close_database', 'CodingSystem', 'CodingProperty',
                     'PropertyValue', 'Interview', 'Utterance', 'UtteranceCode', 'GlobalProperty', 'GlobalValue',
                     'GlobalRating', 'UtteranceStaging', 'GlobalStaging', 'Translation', 'TranslationSource',
                     'TranslationTarget', 'TranslationSourceRoot']

logging.getLogger('database').addHandler(logging.NullHandler())


def init_database(path=":memory:", use_memory_on_failure=True):
    """
    Establish the connecction to the database at path.
    :param path: path to the SQLite database
    :param use_memory_on_failure: Whether to initialize an in-memory database upon failure to connect. Default True
    :return: None
    """
    MEMORY = ":memory:"

    pragmas = (('journal_mode', 'wal'),
               ('cache_size', -1 * 64000),  # 64MB
               ('foreign_keys', 1),
               ('ignore_check_constraints', 0))
    db.init(path, pragmas=pragmas)
    db.execute_sql("PRAGMA foreign_keys = ON;")
    if path != MEMORY:
        try:
            db.connect(reuse_if_open=True)
        except OperationalError as err:
            if use_memory_on_failure:
                logging.error(f"Unable to connect to the database at {path}.\nDefaulting to :memory:")
                db.init(MEMORY, pragmas=pragmas)
                db.connect(reuse_if_open=True)
            else:
                raise err

    db.create_tables([CodingSystem, Interview, CodingProperty, GlobalProperty, PropertyValue,
                      GlobalValue, Utterance, UtteranceCode, GlobalRating, UtteranceStaging,
                      GlobalStaging, Translation, TranslationSource, TranslationTarget, TranslationSourceRoot])


def close_database():
    db.close()
