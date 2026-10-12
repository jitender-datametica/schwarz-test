CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_prcs_main_2 (
AGGREGATE STRING(100) COLLATE 'und:ci' NOT NULL,
dependency STRING(100) COLLATE 'und:ci' NOT NULL,
activate_tmsp DATETIME NOT NULL
);