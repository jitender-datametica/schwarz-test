CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_category_management (
id BIGNUMERIC(38,0) NOT NULL,
test_object_id BIGNUMERIC(38,0),
branch_id BIGNUMERIC(38,0),
source_system_primary_key STRING(50),
source_system_id BIGNUMERIC(38,0),
country_id BIGNUMERIC(38,0),
land STRING(20),
datenlieferant STRING(10),
periode STRING(20),
jahr BIGNUMERIC(38,0),
monat_nr INTEGER,
monat STRING(3),
warengruppe STRING(80),
retailer_type STRING(20),
haendler STRING(50)
);