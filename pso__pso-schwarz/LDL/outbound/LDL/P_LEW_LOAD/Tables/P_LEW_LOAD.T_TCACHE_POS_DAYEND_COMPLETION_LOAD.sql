CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tcache_pos_dayend_completion_load (
context_country STRING(3) COLLATE 'und:ci',
orig_store_nr INTEGER,
dwh_cal_dt DATE,
uuid STRING(60),
dwh_load_id BIGNUMERIC(38,0),
dwh_created DATETIME,
dwh_updated DATETIME
);