CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_MAP_DELIV_TYPE_MOV_TYPE_2_CACHE_MAP_DELIV_TYPE_MOV_TYPE_HIST_2
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  ORDER_TYPE_CD   VARCHAR(20)                   NULL,
  MOV_TYPE_CD     VARCHAR(20)                   NULL,
  DELIV_TYPE_CD   NUMBER(38)                    NULL,
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