CREATE OR REPLACE TABLE ldl_production_p_lew_mart_lead.t_containerliste_klammern_shrt_files_hist (
id STRING(100) COLLATE 'und:ci' NOT NULL,
container_art STRING(100) COLLATE 'und:ci',
container_art_groesse STRING(100) COLLATE 'und:ci',
container_art_sortimentsbereich STRING(100) COLLATE 'und:ci',
container_sortimentsbereich STRING(100) COLLATE 'und:ci',
id_local INTEGER NOT NULL,
country STRING(100) COLLATE 'und:ci' NOT NULL,
desc_int STRING(100) COLLATE 'und:ci',
file_name STRING(100) COLLATE 'und:ci',
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);