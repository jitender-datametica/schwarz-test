CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.it_projekt_plan_nutzen (
it_projekt_id STRING(10) COLLATE 'und:ci' NOT NULL,
plan_revision_id BIGNUMERIC(38,0) NOT NULL,
gj BIGNUMERIC(38,0) NOT NULL,
einm_nutzen_betrag NUMERIC(18,2),
lfd_nutzen_betrag NUMERIC(18,2),
td_insert TIMESTAMP,
td_update TIMESTAMP
);