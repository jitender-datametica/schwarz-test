CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_missing_item_wh_day_status (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
pick_area_id BIGNUMERIC(38,0) NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
missing_item_event_id STRING(20),
missing_status_start_tmsp DATETIME NOT NULL,
missing_status_end_tmsp DATETIME NOT NULL,
missing_status_cd STRING(20) NOT NULL,
missing_item_status_cd STRING(20) NOT NULL,
missing_reason_cd BIGNUMERIC(38,0),
temp_missing_fg BIGNUMERIC(38,0) NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (loc_sid, pick_area_id, item_sid, missing_status_start_tmsp, missing_status_cd, dwh_cal_dt) NOT ENFORCED
);