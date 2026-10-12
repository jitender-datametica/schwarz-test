CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_TCURT_2_CURRENCY_1
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_TCURT_WAERS  VARCHAR(10)                   NULL,
  SRC_WAERS         VARCHAR(20)                   NULL,
  CURR_NAME         VARCHAR(100) COLLATE 'en-ci'  NULL,
  CURR_ISO_CD       VARCHAR(20)                   NULL,
  CURR_DEC          NUMBER(38)                    NULL,
  FACTOR            NUMBER(18,5)                  NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);