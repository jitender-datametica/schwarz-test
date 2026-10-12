CREATE OR REPLACE TABLE kfl_production_dbp_etl_process.ginfo_hyperion_export_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL,
hyperion_account_bez STRING(50) COLLATE 'und:ci' NOT NULL,
hyperion_custom1_bez STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);