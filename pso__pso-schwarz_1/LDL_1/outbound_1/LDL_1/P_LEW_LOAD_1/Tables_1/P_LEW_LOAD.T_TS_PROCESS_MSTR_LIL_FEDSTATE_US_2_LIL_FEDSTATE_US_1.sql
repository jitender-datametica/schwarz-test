CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_process_mstr_lil_fedstate_us_2_lil_fedstate_us_1 (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
region_sid BIGNUMERIC(38),
fedstate_cd STRING(20),
valid_from DATE,
valid_to DATE,
active_fg BIGNUMERIC(38),
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);