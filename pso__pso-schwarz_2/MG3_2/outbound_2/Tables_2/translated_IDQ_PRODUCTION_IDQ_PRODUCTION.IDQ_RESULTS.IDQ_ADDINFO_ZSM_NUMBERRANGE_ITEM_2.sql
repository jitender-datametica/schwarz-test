CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_numberrange_item_2 (
id INTEGER NOT NULL,
test_object_id INTEGER,
source_system_primary_key STRING(1000),
source_system_id INTEGER,
country_id INTEGER,
branch_id INTEGER,
is_relevant INTEGER,
artikelnummer STRING(20),
artikelbez_deutsch STRING(40),
warengruppe STRING(12),
unterwarengruppe STRING(50),
artikelart STRING(4),
artikelstatus STRING(2)
);