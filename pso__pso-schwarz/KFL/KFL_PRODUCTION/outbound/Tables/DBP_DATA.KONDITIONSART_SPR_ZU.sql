CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.konditionsart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
konditionsart_id STRING(4) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
konditionsart_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);