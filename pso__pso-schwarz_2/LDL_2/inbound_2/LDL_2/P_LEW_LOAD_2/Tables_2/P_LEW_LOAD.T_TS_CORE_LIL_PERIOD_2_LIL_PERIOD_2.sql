CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CORE_LIL_PERIOD_2_LIL_PERIOD_2
(
  RECORD_ID         VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  PERIOD_SID        NUMBER(38)                    NULL,
  SRC_PERIOD_CD     VARCHAR(20)                   NULL,
  PERIOD_NAME       VARCHAR(100) COLLATE 'en-ci'  NULL,
  PERIOD_TYPE_ID    NUMBER(38)                    NULL,
  PERIOD_TYPE_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  PERIOD_YEAR       NUMBER(38)                    NULL,
  PERIOD_SID_PY     NUMBER(38)                    NULL,
  PERIOD_SID_PQ     NUMBER(38)                    NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);