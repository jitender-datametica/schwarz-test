CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_TCURW_2_EXCHANGE_RATE_TYPE_2
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  X_RATE_TYPE_SID   NUMBER(38)                    NULL,
  SRC_KURST         VARCHAR(20)                   NULL,
  CURR_SID          NUMBER(38)                    NULL,
  X_RATE_TYPE_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  CURR_CD           VARCHAR(20)                   NULL,
  FIXED_RATE_FG     NUMBER(38)                    NULL,
  SPECIAL_RATE_FG   NUMBER(38)                    NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);