CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_loads_cluster (
cluster_cd STRING(100) COLLATE 'und:ci' NOT NULL,
last_refresh DATETIME,
load_id BIGNUMERIC(38,0),
status STRING(4) COLLATE 'und:ci',
update_timestamp DATETIME NOT NULL
);