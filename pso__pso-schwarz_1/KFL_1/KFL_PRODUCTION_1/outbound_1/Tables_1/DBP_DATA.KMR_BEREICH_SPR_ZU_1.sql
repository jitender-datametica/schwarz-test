CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_bereich_spr_zu_1 (
kmr_bereich_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
kmr_bereich_bez STRING(60) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);