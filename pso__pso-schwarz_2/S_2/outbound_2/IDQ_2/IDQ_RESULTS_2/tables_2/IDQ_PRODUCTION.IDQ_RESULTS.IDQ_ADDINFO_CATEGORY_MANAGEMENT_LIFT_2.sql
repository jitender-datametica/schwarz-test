CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_category_management_lift_2 (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(50),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
land_2 STRING(20),
datenlieferant STRING(10),
periode STRING(20),
jahr BIGNUMERIC(38,0),
monat_2 STRING(3),
warengruppe STRING(80),
haendler STRING(50)
);