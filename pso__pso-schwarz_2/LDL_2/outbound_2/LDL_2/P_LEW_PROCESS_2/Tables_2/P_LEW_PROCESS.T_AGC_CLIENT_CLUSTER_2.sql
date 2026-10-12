CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_agc_client_cluster_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
sap_cluster_cd STRING(100) COLLATE 'und:ci',
pos_cluster_cd STRING(100) COLLATE 'und:ci',
last_updated DATETIME,
last_load_id BIGNUMERIC(38,0)
);