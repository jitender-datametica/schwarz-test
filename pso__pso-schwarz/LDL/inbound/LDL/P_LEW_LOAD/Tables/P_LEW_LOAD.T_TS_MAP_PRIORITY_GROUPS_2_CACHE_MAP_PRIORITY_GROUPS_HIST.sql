CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_MAP_PRIORITY_GROUPS_2_CACHE_MAP_PRIORITY_GROUPS_HIST
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  PRCS_GRP_CD     VARCHAR(20)                   NULL,
  VALID_FROM      DATE                          NULL,
  PRCS_GRP_PRIO   NUMBER(38)                    NULL,
  VALID_TO        DATE                          NULL,
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