CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_sys_load_status_wh_log_2 (
run_id BIGNUMERIC(38,0) NOT NULL,
client_id BIGNUMERIC(38,0) NOT NULL,
wh_loc_sid BIGNUMERIC(38,0),
kpi_id BIGNUMERIC(38,0),
dat_dayend DATE,
rec_cnt BIGNUMERIC(38,0),
run_tmsp DATETIME
);