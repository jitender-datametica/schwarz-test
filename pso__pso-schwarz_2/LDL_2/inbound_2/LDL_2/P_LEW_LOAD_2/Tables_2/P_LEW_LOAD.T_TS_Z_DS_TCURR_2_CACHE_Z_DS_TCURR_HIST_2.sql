CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_TCURR_2_CACHE_Z_DS_TCURR_HIST_2
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  FCURR           VARCHAR(20)                   NULL,
  TCURR           VARCHAR(20)                   NULL,
  KURST           VARCHAR(20)                   NULL,
  GDATU           DATE                          NULL,
  UKURS           NUMBER(18,5)                  NULL,
  ACTIVE_FROM_DT  DATE                          NULL,
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