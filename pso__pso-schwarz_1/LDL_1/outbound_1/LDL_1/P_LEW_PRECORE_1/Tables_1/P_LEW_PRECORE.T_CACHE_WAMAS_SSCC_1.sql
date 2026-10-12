CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_wamas_sscc_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
sscc_id BIGNUMERIC(38,0),
sscc STRING(50),
rcv_id BIGNUMERIC(38,0),
taskid BIGNUMERIC(38,0),
created_date DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);