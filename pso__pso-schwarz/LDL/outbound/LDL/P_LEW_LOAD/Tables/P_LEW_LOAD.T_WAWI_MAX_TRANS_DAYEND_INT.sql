CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_wawi_max_trans_dayend_int (
country_iso_cd STRING(3) COLLATE 'und:ci',
data_type STRING(20) COLLATE 'und:ci',
interface STRING(30) COLLATE 'und:ci',
dat_dayend DATE,
wh_id BIGNUMERIC(38),
time_trans DATETIME
);