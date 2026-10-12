CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_clients_stores_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
effective_client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
store_sid BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
store_grp_luxembourg_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
orig_store_nr STRING(16777216),
store_name STRING(16777216),
PRIMARY KEY (client_id, store_sid) NOT ENFORCED
);