CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_wawi_numberrange_item_1 (
id INTEGER NOT NULL,
test_object_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
is_relevant INTEGER,
artikelnummer STRING(14),
artikelbez_lang STRING(100),
warengruppe INTEGER,
unterwarengruppe STRING(20),
artikelstatus INTEGER,
relevanzkriterien STRING(250),
artikelbez_deutsch STRING(40)
);