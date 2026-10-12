CREATE TABLE IF NOT EXISTS ldl_bcbi_fe_mstr_bcbi.t_time_tracking_record_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
time_record_id BIGNUMERIC(38,0) NOT NULL,
time_record_change_dt DATE NOT NULL,
employee_hash STRING(100) COLLATE 'und:ci',
time_type_sid BIGNUMERIC(38,0),
event_type_cd STRING(3) COLLATE 'und:ci',
event_tmsp DATETIME,
event_booking_type_cd STRING(1) COLLATE 'und:ci',
cancel_fg BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
timestamp_load_bcbi TIMESTAMP
);