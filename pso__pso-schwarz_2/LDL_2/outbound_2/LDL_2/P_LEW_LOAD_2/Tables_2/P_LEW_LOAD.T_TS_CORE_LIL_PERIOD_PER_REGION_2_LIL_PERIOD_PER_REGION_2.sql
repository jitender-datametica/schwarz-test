CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_core_lil_period_per_region_2_lil_period_per_region_2 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
period_sid BIGNUMERIC(38),
region_sid BIGNUMERIC(38),
start_dt DATE,
end_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);