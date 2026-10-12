CREATE OR REPLACE TABLE p_lew_precore.t_cache_containerliste_klammern_1 (
id STRING(100) COLLATE 'und:ci' NOT NULL,
container_art STRING(100) COLLATE 'und:ci',
container_art_groesse STRING(100) COLLATE 'und:ci',
container_art_sortimentsbereich STRING(100) COLLATE 'und:ci',
container_sortimentsbereich STRING(100) COLLATE 'und:ci',
id_local INTEGER NOT NULL,
country_1 STRING(100) COLLATE 'und:ci' NOT NULL,
desc_int STRING(100) COLLATE 'und:ci',
file_name STRING(100) COLLATE 'und:ci',
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);