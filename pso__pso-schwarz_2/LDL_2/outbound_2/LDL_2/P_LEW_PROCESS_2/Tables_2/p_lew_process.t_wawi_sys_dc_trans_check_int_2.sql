CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_dc_trans_check_int_2 (
country_iso_cd STRING(3) COLLATE 'und:ci',
wh_id INTEGER,
interface STRING(30) COLLATE 'und:ci',
cur_dat_dayend DATE,
dc_server_id INTEGER DEFAULT 1,
dc_load_id INTEGER,
etl_type STRING(30) COLLATE 'und:ci',
l_0_cnt INTEGER DEFAULT 0
);