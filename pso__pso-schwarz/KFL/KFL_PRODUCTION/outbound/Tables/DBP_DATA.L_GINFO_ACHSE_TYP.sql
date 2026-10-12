CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ginfo_achse_typ (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ginfo_achse_typ_id STRING(10) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);