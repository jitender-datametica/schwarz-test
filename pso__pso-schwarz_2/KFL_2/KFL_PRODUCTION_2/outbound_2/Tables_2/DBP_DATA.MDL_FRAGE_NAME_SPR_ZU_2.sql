CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mdl_frage_name_spr_zu_2 (
frage_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
frage_name_bez STRING(80) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);