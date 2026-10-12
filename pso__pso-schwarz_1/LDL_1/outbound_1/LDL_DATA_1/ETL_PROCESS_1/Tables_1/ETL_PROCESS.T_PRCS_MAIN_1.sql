CREATE TABLE IF NOT EXISTS ldl_data_etl_process.t_prcs_main_1 (
aggregate STRING(100) COLLATE 'und:ci' NOT NULL,
dependency STRING(100) COLLATE 'und:ci' NOT NULL,
activate_tmsp DATETIME NOT NULL
);