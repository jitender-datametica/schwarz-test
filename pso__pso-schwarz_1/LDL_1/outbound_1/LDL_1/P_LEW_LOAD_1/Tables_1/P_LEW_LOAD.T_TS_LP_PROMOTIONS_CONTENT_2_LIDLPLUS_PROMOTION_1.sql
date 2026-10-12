CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lp_promotions_content_2_lidlplus_promotion_1 (
record_id INTEGER,
client_id BIGNUMERIC(38),
lidlplus_prom_sid BIGNUMERIC(38),
src_external_id STRING(100),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);