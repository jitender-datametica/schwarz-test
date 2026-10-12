CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.teku_frage_spr_zu_1 (
teku_frage_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
teku_frage_bez STRING(150) COLLATE 'und:ci',
teku_frage_bez_lang STRING(100) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);