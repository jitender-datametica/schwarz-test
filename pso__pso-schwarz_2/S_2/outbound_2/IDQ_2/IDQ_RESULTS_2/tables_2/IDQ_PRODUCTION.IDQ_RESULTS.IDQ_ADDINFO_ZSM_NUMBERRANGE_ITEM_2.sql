CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_zsm_numberrange_item_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
artikelnummer STRING(20),
artikelbez_deutsch STRING(40),
warengruppe STRING(12),
unterwarengruppe STRING(50),
artikelart STRING(4),
artikelstatus STRING(2)
);