CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_sql_pos_clean_vat_avg_2_cache_pos_store_vat_avg (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
sql_pos_clean_vat_avg_loc_sid_store INTEGER NOT NULL,
sql_pos_clean_vat_avg_dwh_cal_dt DATE NOT NULL,
loc_sid_store BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE NOT NULL,
loc_sid_wh BIGNUMERIC(38),
sales_val NUMERIC(18,5),
sales_net_val NUMERIC(18,5),
avg_pct_vat_store NUMERIC(18,5),
avg_pct_vat_store_prvs_shadow NUMERIC(18,5),
avg_pct_vat_wh NUMERIC(18,5),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);