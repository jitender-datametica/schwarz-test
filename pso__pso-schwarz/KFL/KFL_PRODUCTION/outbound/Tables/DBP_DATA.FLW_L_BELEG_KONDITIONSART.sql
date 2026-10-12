CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_beleg_konditionsart (
mandant_id BIGNUMERIC(38,0) NOT NULL,
beleg_konditionsart_id STRING(4) DEFAULT '    ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);