CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transaktion_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transaktion_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
transaktion_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);