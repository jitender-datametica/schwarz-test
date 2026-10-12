CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tp_merkmalart_spr_zu (
tp_merkmalart_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmal_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
tp_merkmalart_bez STRING(160) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);