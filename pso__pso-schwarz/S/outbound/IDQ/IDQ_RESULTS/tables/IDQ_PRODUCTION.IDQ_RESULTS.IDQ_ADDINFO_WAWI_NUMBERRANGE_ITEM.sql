CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_wawi_numberrange_item (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
artikelnummer STRING(14),
artikelbez_lang STRING(100),
warengruppe BIGNUMERIC(38,0),
unterwarengruppe STRING(20),
artikelstatus BIGNUMERIC(38,0),
relevanzkriterien STRING(250),
artikelbez_deutsch STRING(40)
);