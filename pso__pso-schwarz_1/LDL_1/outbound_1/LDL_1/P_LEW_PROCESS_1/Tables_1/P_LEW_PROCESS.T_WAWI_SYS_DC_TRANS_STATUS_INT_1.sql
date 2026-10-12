CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_sys_dc_trans_status_int_1 (
load_id BIGNUMERIC(38,0) NOT NULL,
dc_server_id BIGNUMERIC(38,0),
dc_load_id BIGNUMERIC(38,0),
country_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL,
wh_id BIGNUMERIC(38,0),
dat_dayend DATE,
etl_type STRING(30) COLLATE 'und:ci' NOT NULL,
interface_name STRING(30) COLLATE 'und:ci' NOT NULL,
l_0_cnt BIGNUMERIC(38,0) DEFAULT 0,
l_cnt BIGNUMERIC(38,0) DEFAULT 0,
timestamp_start DATETIME,
timestamp_end DATETIME
);