CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.lagertyp_griffzone_typ_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
griffzone_typ_id STRING(1) COLLATE 'und:ci' NOT NULL,
lagertyp_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);