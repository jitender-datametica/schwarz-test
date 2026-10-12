CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventurart_int_spr_zu_1 (
spr_id BIGNUMERIC(38,0) NOT NULL,
inventurart_int_id BIGNUMERIC(38,0) NOT NULL,
inventurart_int_bez STRING(100) COLLATE 'und:ci' DEFAULT ' ',
td_insert TIMESTAMP,
td_update TIMESTAMP
);