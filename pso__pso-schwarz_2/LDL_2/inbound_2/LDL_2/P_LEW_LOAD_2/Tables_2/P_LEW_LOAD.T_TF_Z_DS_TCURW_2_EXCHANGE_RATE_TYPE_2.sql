CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_TCURW_2_EXCHANGE_RATE_TYPE_2
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_TCURW_SPRAS  VARCHAR(2)                    NULL,
  Z_DS_TCURW_KURST  VARCHAR(8)                    NULL,
  SRC_KURST         VARCHAR(20)                   NULL,
  SRC_WAERS         VARCHAR(40)                   NULL,
  X_RATE_TYPE_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  CURR_CD           VARCHAR(20)                   NULL,
  FIXED_RATE_FG     NUMBER(38)                    NULL,
  SPECIAL_RATE_FG   NUMBER(38)                    NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);