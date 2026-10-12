CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_time_type_hist_2 (
client_id BIGNUMERIC(38,0),
time_type_sid BIGNUMERIC(38,0),
time_type_short_descr STRING(250),
time_type_descr STRING(250),
presence_fg BIGNUMERIC(38,0),
performance_relevant_fg BIGNUMERIC(38,0),
active_from_dt DATE,
active_to_dt DATE,
deleted_fg BIGNUMERIC(38,0),
dwh_valid_from DATE,
dwh_valid_to DATE,
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME,
timestamp_load_bcbi TIMESTAMP
);