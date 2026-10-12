CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_cbx_item_continenttype_2_mdm_market (
record_id INTEGER,
client_id BIGNUMERIC(38),
market_sid BIGNUMERIC(38),
market_cd STRING(20) COLLATE 'und:ci',
market STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);