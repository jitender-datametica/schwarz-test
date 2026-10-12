CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_sql_cache_vat_avg_2_pos_store_vat_avg_2 (
client_id BIGNUMERIC(38) NOT NULL,
lidl_country STRING(40) NOT NULL,
sql_cache_vat_avg_loc_sid INTEGER NOT NULL,
sql_cache_vat_avg_dwh_cal_dt DATE NOT NULL,
loc_sid BIGNUMERIC(38) NOT NULL,
dwh_cal_dt DATE NOT NULL,
avg_pct_vat NUMERIC(18,5),
extraction_dt DATE,
dwh_mapping_dt DATE NOT NULL,
tf_error_fg INTEGER,
record_id STRING(300) NOT NULL,
filename STRING(1000) NOT NULL
);