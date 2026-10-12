CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_dc_trans_dayend_int_1 (
country_iso_cd STRING(3) COLLATE 'und:ci',
data_type STRING(20) COLLATE 'und:ci',
interface STRING(30) COLLATE 'und:ci',
dat_dayend DATE,
wh_id INTEGER,
time_trans DATETIME
);