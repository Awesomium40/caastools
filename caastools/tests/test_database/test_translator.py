from caastools.database import init_database, close_database
from caastools.database.translation import *
from caastools.database.model import *
import unittest

DB_PATH = r'H:\U24-Kahler\UCHAT_Data_Management\DATA\REACH2\reach2.db'
init_database(DB_PATH)

sources = list(
    PropertyValue
    .select()
    .join(CodingProperty)
    .join(CodingSystem)
    .where((CodingSystem.cs_name == 'UCHAT3.31') & (PropertyValue.pv_value.in_(['r', '-2'])))
    .execute()
)

t = Translator('UCHAT3.31', 'UCHAT 3.4')
target = t.translate('property', *sources)


close_database()