CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_wh_new_1 (
client_id INTEGER NOT NULL,
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id INTEGER NOT NULL,
dat_dayend DATE NOT NULL,
dat_dayend_mmo_master DATE,
dat_dayend_mmo_move DATE,
wh_new_loc_sid INTEGER,
wh_new_time_trans DATETIME,
wh_new_status STRING(10) COLLATE 'und:ci',
wh_new_err_text STRING(200) COLLATE 'und:ci'
);