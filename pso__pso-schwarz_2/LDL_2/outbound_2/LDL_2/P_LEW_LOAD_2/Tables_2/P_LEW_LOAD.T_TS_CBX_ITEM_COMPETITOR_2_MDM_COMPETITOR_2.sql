CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_competitor_2_mdm_competitor_2 (
record_id INTEGER,
client_id BIGNUMERIC(38),
competitor_sid BIGNUMERIC(38),
src_competitor_cd STRING(20) COLLATE 'und:ci',
competitor_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);