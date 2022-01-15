from caastools.database import init_database, close_database
from caastools.database.translation import *
from caastools.database.model import *
import unittest


class TranslationTest(unittest.TestCase):

    def setUp(self) -> None:
        init_database()

    def tearDown(self) -> None:
        close_database()

    def test_add_property_translation(self):

        # Create the sources of the translation
        source_system = CodingSystem.create(cs_name="SOURCE_CODING_SYSTEM", cs_path='./source_cs')
        source_misc_property = CodingProperty.create(coding_system=source_system, cp_name="MISC",
                                                     cp_display_name="MISC", cp_description="MISC2.5")
        source_sr_property = CodingProperty.create(coding_system=source_system, cp_name="Strength Rating",
                                                   cp_display_name="Strength",
                                                   cp_description="Strength of Client CT/ST")

        source_misc_value = PropertyValue.create(pv_value='r', pv_description='reason',
                                                 coding_property=source_misc_property)
        source_sr_value = PropertyValue.create(pv_value='-2', pv_description='Away from change 2',
                                                    coding_property=source_sr_property)

        # Create the target of the translation
        target_system = CodingSystem.create(cs_name="TARGET_CODING_SYSTEM", cs_path='./target_cs')
        target_misc_property = CodingProperty.create(coding_system=target_system, cp_name="MISC",
                                                     cp_display_name="MISC", cp_description="MISC2.5")
        target_misc_value = PropertyValue.create(pv_value='r-', pv_description='reason not to change',
                                                 coding_property=target_misc_property)

        # Test that Coding System with specified name must exist for both source and target
        with self.assertRaises(CodingSystem.DoesNotExist):
            add_property_translation('bad_cs_name', target_system.cs_name, [source_misc_value, source_sr_value],
                                     target_misc_value)

        with self.assertRaises(CodingSystem.DoesNotExist):
            add_property_translation(source_system.cs_name, 'bad_cs_name', [source_misc_value, source_sr_value],
                                     target_misc_value)

        # test that a new translation can be added

        add_property_translation(
            source_system.cs_name, target_system.cs_name, [source_misc_value, source_sr_value], target_misc_value
        )

        # Assert that translation inserted correctly
        translation = (
            Translation
            .select()
            .where((Translation.source_cs == source_system) & (Translation.target_cs == target_system))
            .get()
        )
        self.assertIsNotNone(translation)

        # Test that source and targets were also inserted successfully
        target: TranslationTarget = (
            TranslationTarget
            .select()
            .where(TranslationTarget.parent_primary_key == target_misc_value.property_value_id)
            .get()
        )
        self.assertEqual(target.translation.translation_id, translation.translation_id)

        source = list(
            TranslationSource
            .select()
            .where(TranslationSource.parent_primary_key.in_([x.property_value_id for x in
                                                             (source_misc_value, source_sr_value)]))
            .execute()
        )
        self.assertEqual(len(source), 2)
        for s in source:
            self.assertEqual(s.translation.translation_id, translation.translation_id)

