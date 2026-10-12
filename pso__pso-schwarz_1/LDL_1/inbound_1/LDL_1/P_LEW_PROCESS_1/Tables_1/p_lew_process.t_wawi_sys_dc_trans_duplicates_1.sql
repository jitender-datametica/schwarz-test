CREATE TABLE p_lew_process.t_wawi_sys_dc_trans_duplicates_1
     (
country_iso_cd VARCHAR(3) COLLATE 'en-ci',
interface VARCHAR(30) COLLATE 'en-ci',
dat_dayend DATE,
dc_load_id INTEGER,
etl_type VARCHAR(30) COLLATE 'en-ci',
wh_id INTEGER,
count_rows INTEGER,
timestamp_delete TIMESTAMP(0));