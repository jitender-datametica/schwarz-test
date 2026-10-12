CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_elwis_ladestatus_1 (
country_1 STRING(2) COLLATE 'und:ci',
extr_type STRING(10) COLLATE 'und:ci',
dat_dayend DATE,
run_endtime DATETIME,
extr_soll BIGNUMERIC(38,0),
extr_succ BIGNUMERIC(38,0),
load_succ BIGNUMERIC(38,0),
extr_failed STRING(10000) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);