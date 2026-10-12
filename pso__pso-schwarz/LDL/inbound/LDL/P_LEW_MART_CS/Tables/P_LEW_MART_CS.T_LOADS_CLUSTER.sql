  CREATE TABLE P_LEW_MART_CS.T_LOADS_CLUSTER (
	cluster_cd VARCHAR(100) NOT NULL COLLATE 'en-ci',
	last_refresh TIMESTAMP_NTZ(9),
	load_id NUMBER(38,0),
	status VARCHAR(4) COLLATE 'en-ci',
	update_timestamp TIMESTAMP_NTZ(9) NOT NULL
)
;