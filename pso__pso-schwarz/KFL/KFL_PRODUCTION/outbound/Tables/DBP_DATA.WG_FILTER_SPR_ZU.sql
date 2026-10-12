CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wg_filter_spr_zu (
wg_filter_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
wg_filter_bez STRING(255) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);