CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_TCURR_2_EXCHANGE_RATE_KNOWN_HIST
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  CURR_SID_FROM   NUMBER(38)                    NULL,
  CURR_SID_TO     NUMBER(38)                    NULL,
  X_RATE_TYPE_SID NUMBER(38)                    NULL,
  ACTIVE_FROM_DT  DATE                          NULL,
  ACTIVE_TO_DT    DATE                          NULL,
  CURR_CD_FROM    VARCHAR(20)                   NULL,
  CURR_CD_TO      VARCHAR(20)                   NULL,
  EXCHANGE_RATE   NUMBER(18,5)                  NULL,
  DELETED_FG      NUMBER(38)                    NULL,
  DWH_VALID_FROM  DATE                          NULL,
  DWH_VALID_TO    DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);