CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_problemgruppe (
system_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemgruppe_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);