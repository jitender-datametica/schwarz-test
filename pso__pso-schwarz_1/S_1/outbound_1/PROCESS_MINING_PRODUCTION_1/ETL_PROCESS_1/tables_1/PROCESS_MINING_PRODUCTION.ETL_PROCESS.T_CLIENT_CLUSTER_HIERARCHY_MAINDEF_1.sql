CREATE OR REPLACE TABLE process_mining_production_etl_process.t_client_cluster_hierarchy_maindef_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_cd STRING(20),
cluster_type STRING(20),
cluster_area_cd STRING(100) COLLATE 'und:ci',
cluster_area_type STRING(20),
last_updated DATETIME,
last_load_id BIGNUMERIC(38,0)
);