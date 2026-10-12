CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_time_abverkauf (
client_id BIGNUMERIC(38,0),
loc_sid BIGNUMERIC(38,0),
receipt_dt DATE,
dwh_cal_dt DATE,
abverkauf BIGNUMERIC(38,0),
timestamp_load_bcbi TIMESTAMP
);