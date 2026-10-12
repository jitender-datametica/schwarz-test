CREATE TABLE P_LEW_PROCESS.T_EJR_LIVE_MONITORING_THRESHOLDS_2 (
	CLIENT_ID NUMBER(38,0) COMMENT 'unique identifier of the DWH client',
	RED_STORE_THRESHOLD_PCT NUMBER(38,5) COMMENT 'a percentage benchmark, for the proportion of red stores, above which the client assumes a red status_2',
	ORANGE_STORE_THRESHOLD_PCT NUMBER(38,5) COMMENT 'a percentage benchmark, for the proportion of orange stores, above which the client assumes an orange status_2',
	CONSTRAINT PK_T_EJR_LIVE_MONITORING_THRESHOLDS PRIMARY KEY (CLIENT_ID)
) COMMENT = 'Monitoring actions based on client-level live ejr receipt delays can be configured on a per client basis in this table';