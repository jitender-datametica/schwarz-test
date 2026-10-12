CREATE TABLE p_lew_process.t_wawi_sys_dc_trans_check_int
     (
country_iso_cd VARCHAR(3) COLLATE 'en-ci',
wh_id INTEGER,
interface VARCHAR(30) COLLATE 'en-ci',
cur_dat_dayend DATE,
dc_server_id INTEGER DEFAULT 1 ,
dc_load_id INTEGER,
etl_type VARCHAR(30) COLLATE 'en-ci',
l_0_cnt INTEGER DEFAULT 0 );