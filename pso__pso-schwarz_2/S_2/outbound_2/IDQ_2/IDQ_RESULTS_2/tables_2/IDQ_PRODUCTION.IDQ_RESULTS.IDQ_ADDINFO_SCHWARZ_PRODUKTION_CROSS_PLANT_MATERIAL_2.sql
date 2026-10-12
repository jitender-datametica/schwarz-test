CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_schwarz_produktion_cross_plant_material_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(1000),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
is_relevant BIGNUMERIC(38,0),
maktx STRING(40),
matkl STRING(9),
mstae STRING(2),
werks STRING(1000),
content_hash_code STRING(32),
PRIMARY KEY (id) NOT ENFORCED
);