CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_wg_filter_1 (
wg_filter_id BIGNUMERIC(38,0) NOT NULL,
kommentar STRING(255) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);