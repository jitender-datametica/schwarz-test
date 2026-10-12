CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_sql_cache_vat_avg_2_pos_store_vat_avg (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
loc_sid BIGNUMERIC(38),
dwh_cal_dt DATE,
avg_pct_vat NUMERIC(18,5),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);