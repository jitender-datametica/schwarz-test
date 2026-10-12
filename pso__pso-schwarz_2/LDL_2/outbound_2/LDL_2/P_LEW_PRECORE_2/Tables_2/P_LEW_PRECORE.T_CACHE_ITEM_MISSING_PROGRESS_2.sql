CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_item_missing_progress_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_missing_id NUMERIC(20,0) NOT NULL,
item_missing_progress_id BIGNUMERIC(38,0) NOT NULL,
missing_activity_cd STRING(20),
missing_state_cd STRING(20),
missing_state_prev_cd STRING(20),
missing_reason_cd STRING(20),
missing_reason_prev_cd STRING(20),
creation_dttm DATETIME,
change_dttm DATETIME,
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, item_missing_id, item_missing_progress_id) NOT ENFORCED
);