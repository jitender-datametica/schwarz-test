CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.verkaufsorganisation_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
verkaufsorganisation_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);