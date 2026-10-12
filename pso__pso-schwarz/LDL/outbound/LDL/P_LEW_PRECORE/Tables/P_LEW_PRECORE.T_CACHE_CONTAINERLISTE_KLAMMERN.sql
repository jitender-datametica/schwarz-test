CREATE TABLE IF NOT EXISTS ldl_p_lew_precore.t_cache_containerliste_klammern (
id STRING(100) COLLATE 'und:ci' NOT NULL,
container_art STRING(100) COLLATE 'und:ci',
container_art_groesse STRING(100) COLLATE 'und:ci',
container_art_sortimentsbereich STRING(100) COLLATE 'und:ci',
container_sortimentsbereich STRING(100) COLLATE 'und:ci',
id_local BIGNUMERIC(38,0) NOT NULL,
country STRING(100) COLLATE 'und:ci' NOT NULL,
desc_int STRING(100) COLLATE 'und:ci',
file_name STRING(100) COLLATE 'und:ci',
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);