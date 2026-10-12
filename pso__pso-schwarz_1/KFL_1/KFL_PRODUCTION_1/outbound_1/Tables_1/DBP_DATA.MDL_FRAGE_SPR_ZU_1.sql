CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_frage_spr_zu_1 (
frage_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
frage_bez STRING(200) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);