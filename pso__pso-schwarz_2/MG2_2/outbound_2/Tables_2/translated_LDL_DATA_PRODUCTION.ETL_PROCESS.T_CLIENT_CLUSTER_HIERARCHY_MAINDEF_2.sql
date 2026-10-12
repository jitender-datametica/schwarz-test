CREATE OR REPLACE TABLE ldl_data_production_etl_process.t_client_cluster_hierarchy_maindef_2 (
client_id INTEGER NOT NULL,
country_cd STRING(20),
cluster_type STRING(20),
cluster_area_cd STRING(100) COLLATE 'und:ci',
cluster_area_type STRING(20),
last_updated DATETIME,
last_load_id INTEGER
);