CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods.l_bon_load_status_bitfeld (
bitfeld_position_id BIGNUMERIC(38,0) NOT NULL,
load_status_bez STRING(255),
td_insert TIMESTAMP,
td_update TIMESTAMP
);