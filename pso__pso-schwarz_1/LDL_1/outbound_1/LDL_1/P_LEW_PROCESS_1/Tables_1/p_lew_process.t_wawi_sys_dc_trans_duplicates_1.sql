CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_dc_trans_duplicates_1 (
country_iso_cd STRING(3) COLLATE 'und:ci',
interface STRING(30) COLLATE 'und:ci',
dat_dayend DATE,
dc_load_id INTEGER,
etl_type STRING(30) COLLATE 'und:ci',
wh_id INTEGER,
count_rows INTEGER,
timestamp_delete DATETIME
);