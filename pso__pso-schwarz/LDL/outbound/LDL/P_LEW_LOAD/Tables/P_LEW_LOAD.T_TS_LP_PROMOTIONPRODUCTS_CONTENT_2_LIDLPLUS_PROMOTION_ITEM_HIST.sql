CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_lp_promotionproducts_content_2_lidlplus_promotion_item_hist (
record_id INTEGER,
client_id BIGNUMERIC(38),
lidlplus_prom_sid BIGNUMERIC(38),
item_sid BIGNUMERIC(38),
validity_start_tmsp DATETIME,
validity_end_tmsp DATETIME,
deleted_fg BIGNUMERIC(38),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);