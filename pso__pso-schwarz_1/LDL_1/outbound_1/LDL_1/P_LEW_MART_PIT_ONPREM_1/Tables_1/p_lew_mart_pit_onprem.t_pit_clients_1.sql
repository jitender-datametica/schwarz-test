CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit_onprem.t_pit_clients_1 (
client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
effective_client_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
luxembourg_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
PRIMARY KEY (client_id, effective_client_id) NOT ENFORCED
);