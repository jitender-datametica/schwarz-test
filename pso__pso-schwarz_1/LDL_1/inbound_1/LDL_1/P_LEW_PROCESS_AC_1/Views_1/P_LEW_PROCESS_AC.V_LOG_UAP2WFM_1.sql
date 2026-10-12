CREATE OR REPLACE VIEW P_LEW_PROCESS_AC.V_LOG_UAP2WFM_1
(
    proj_name
    , hive_table_name
    , date_partkey
    , daily_run_counter
    , last_upd_timestamp
    , uap_cluster
    , wfm_env_name
)   
AS
   SELECT
    proj_name,
    hive_table_name,
    date_partkey,
    daily_run_counter,
    last_upd_timestamp,
    uap_cluster,
    wfm_env_name
  FROM P_LEW_PROCESS.T_LOG_UAP2WFM_1
;






/*CREATE TABLE P_LEW_PROCESS.T_LOG_UAP2WFM_1 (
	PROJ_NAME VARCHAR(10) NOT NULL COLLATE 'en-ci',
	HIVE_TABLE_NAME VARCHAR(50) NOT NULL COLLATE 'en-ci',
	DATE_PARTKEY DATE NOT NULL,
	DAILY_RUN_COUNTER INTEGER NOT NULL,
	LAST_UPD_TIMESTAMP TIMESTAMP_NTZ(9) NOT NULL,
	UAP_CLUSTER VARCHAR(2) NOT NULL COLLATE 'en-ci',
	WFM_ENV_NAME VARCHAR(4) NOT NULL COLLATE 'en-ci',
	UNIQUE (PROJ_NAME, HIVE_TABLE_NAME, DATE_PARTKEY, DAILY_RUN_COUNTER,WFM_ENV_NAME)
);*/
