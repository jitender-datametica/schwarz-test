CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_ewm_item_missing_progress_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_missing_id NUMERIC(20,0) NOT NULL,
orig_item_nr BIGNUMERIC(38,0),
case_size BIGNUMERIC(38,0),
item_sid BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0),
storage_loc_cd STRING(20),
missing_state_cd STRING(20),
missing_reason_cd STRING(20),
creation_dttm DATETIME,
change_dttm DATETIME NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, item_missing_id, change_dttm, dwh_cal_dt) NOT ENFORCED
);