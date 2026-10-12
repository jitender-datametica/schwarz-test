CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_TCURC_2_CURRENCY
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  CURR_SID        NUMBER(38)                    NULL,
  SRC_WAERS       VARCHAR(20)                   NULL,
  CURR_NAME       VARCHAR(100) COLLATE 'en-ci'  NULL,
  CURR_ISO_CD     VARCHAR(20)                   NULL,
  CURR_DEC        NUMBER(38)                    NULL,
  FACTOR          NUMBER(18,5)                  NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);