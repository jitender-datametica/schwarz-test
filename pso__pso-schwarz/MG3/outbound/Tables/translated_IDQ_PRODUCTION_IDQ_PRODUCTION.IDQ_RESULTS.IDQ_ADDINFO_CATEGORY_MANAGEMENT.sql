CREATE OR REPLACE TABLE idq_production_idq_results.idq_addinfo_category_management (
id INTEGER NOT NULL,
test_object_id INTEGER,
branch_id INTEGER,
source_system_primary_key STRING(50),
source_system_id INTEGER,
country_id INTEGER,
land STRING(20),
datenlieferant STRING(10),
periode STRING(20),
jahr INTEGER,
monat_nr INTEGER,
monat STRING(3),
warengruppe STRING(80),
retailer_type STRING(20),
haendler STRING(50)
);