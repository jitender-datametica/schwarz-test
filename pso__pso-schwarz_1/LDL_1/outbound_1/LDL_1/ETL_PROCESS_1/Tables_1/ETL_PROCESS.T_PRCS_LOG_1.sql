CREATE TABLE IF NOT EXISTS ldl_etl_process.t_prcs_log_1 (
aggregate STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_node_cd STRING(20) COLLATE 'und:ci' NOT NULL,
country_cd STRING COLLATE 'und:ci',
dwh_cal_dt DATE NOT NULL,
loc_sid INTEGER,
recalc_fg INTEGER NOT NULL,
status_1 INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
create_tmsp DATETIME NOT NULL,
update_tmsp DATETIME,
start_tmsp DATETIME,
end_tmsp DATETIME
);