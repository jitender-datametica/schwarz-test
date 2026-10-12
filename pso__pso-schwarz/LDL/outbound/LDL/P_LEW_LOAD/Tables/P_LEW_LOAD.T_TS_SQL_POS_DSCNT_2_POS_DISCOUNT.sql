CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_ts_sql_pos_dscnt_2_pos_discount (
record_id STRING(1000) COLLATE 'und:ci',
client_id BIGNUMERIC(38),
discount_sid BIGNUMERIC(38),
src_discount_nr STRING(100) COLLATE 'und:ci',
src_posart STRING(1) COLLATE 'und:ci',
src_discount_pct NUMERIC(18,5),
discount_descr STRING(100) COLLATE 'und:ci',
first_appearance_dt DATE,
dwh_load_id BIGNUMERIC(38),
dwh_created DATETIME,
dwh_updated DATETIME,
dwh_mapping_dt DATE,
error_fg BIGNUMERIC(38),
error_descr STRING(1000) COLLATE 'und:ci',
filename STRING(1000) COLLATE 'und:ci',
hist_row_no BIGNUMERIC(38)
);