CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.markant_tage_dispo_map_1 (
anz_arbeitstage BIGNUMERIC(38,0) NOT NULL,
anz_kalendertage_mo BIGNUMERIC(38,0),
anz_kalendertage_di BIGNUMERIC(38,0),
anz_kalendertage_mi BIGNUMERIC(38,0),
anz_kalendertage_do BIGNUMERIC(38,0),
anz_kalendertage_fr BIGNUMERIC(38,0),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);