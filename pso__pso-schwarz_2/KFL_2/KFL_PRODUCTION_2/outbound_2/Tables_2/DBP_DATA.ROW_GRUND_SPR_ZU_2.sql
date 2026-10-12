CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.row_grund_spr_zu_2 (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
row_grund_id STRING(3) NOT NULL,
row_grund_bez STRING(40),
td_update TIMESTAMP,
td_insert TIMESTAMP
);