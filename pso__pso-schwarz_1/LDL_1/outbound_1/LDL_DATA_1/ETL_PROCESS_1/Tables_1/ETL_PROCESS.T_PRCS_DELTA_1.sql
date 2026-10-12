CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_prcs_delta_1 (
dependency STRING(100) COLLATE 'und:ci' NOT NULL,
dwh_node_cd STRING(20) COLLATE 'und:ci' NOT NULL,
country_cd STRING COLLATE 'und:ci',
dwh_cal_dt DATE NOT NULL,
loc_sid INTEGER,
load_tmsp DATETIME NOT NULL,
dwh_load_id INTEGER NOT NULL
);