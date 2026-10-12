CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.immo_l_gebiet (
mandant_id BIGNUMERIC(38,0) NOT NULL,
gebiet_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);