CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.ginfo_hyperion_export_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ginfo_flaeche_id STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL,
hyperion_account_bez STRING(50) COLLATE 'und:ci' NOT NULL,
hyperion_custom1_bez STRING(50) COLLATE 'und:ci' NOT NULL,
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);