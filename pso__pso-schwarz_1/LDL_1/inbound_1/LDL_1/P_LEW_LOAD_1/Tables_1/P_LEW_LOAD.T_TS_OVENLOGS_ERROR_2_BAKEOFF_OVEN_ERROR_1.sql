CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_OVENLOGS_ERROR_2_BAKEOFF_OVEN_ERROR_1
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  LOC_SID_WH        NUMBER(38)                    NULL,
  LOC_SID_STORE     NUMBER(38)                    NULL,
  OVEN_ID           NUMBER(38)                    NULL,
  OVEN_IP           VARCHAR(20)                   NULL,
  OVEN_BRAND        VARCHAR(20) COLLATE 'en-ci'   NULL,
  OVEN_ERROR_TMSP   TIMESTAMP_NTZ(6)              NULL,
  OVEN_ERROR_ID     NUMBER(38)                    NULL,
  OVEN_ERROR_DESCR  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_CAL_DT        DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);