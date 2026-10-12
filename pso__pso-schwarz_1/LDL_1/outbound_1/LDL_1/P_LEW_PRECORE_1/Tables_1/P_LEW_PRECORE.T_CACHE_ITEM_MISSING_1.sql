CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_item_missing_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
item_missing_id NUMERIC(20,0) NOT NULL,
item_sid BIGNUMERIC(38,0),
loc_sid BIGNUMERIC(38,0),
storage_loc_cd STRING(20),
dwh_cal_dt DATE NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);