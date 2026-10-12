CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_wawi_pim_delta_log_2 (
ctrcode STRING(3) COLLATE 'und:ci' NOT NULL,
wh_nr STRING(5),
table_name STRING(16777216),
max_scn BIGNUMERIC(38,0),
created_tmsp DATETIME,
updated_tmsp DATETIME
);