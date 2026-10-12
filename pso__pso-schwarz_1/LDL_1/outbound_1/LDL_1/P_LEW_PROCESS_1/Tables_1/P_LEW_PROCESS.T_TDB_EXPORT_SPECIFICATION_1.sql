CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_tdb_export_specification_1 (
client_id BIGNUMERIC(38,0) NOT NULL,
country_lidl_cd STRING(20) NOT NULL,
export_cluster_id BIGNUMERIC(38,0),
active_from_dt DATE NOT NULL,
active_to_dt DATE NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL,
PRIMARY KEY (client_id, active_from_dt) NOT ENFORCED
);