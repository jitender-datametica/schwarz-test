CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_OVENLOGS_ERROR_2_BAKEOFF_OVEN_ERROR_1
(
  CLIENT_ID                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  OVENLOGS_ERROR_COUNTRY_ISO_CD VARCHAR(250)                  NULL,
  OVENLOGS_ERROR_ORIG_STORE_NR  NUMBER(38,0)                  NULL,
  OVENLOGS_ERROR_OVEN_NUMBER    NUMBER(38,0)                  NULL,
  OVENLOGS_ERROR_ERROR_DATETIME TIMESTAMP_NTZ(0)              NULL,
  OVENLOGS_ERROR_ERROR_ID       VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_WH_ID                     NUMBER(10,0)                  NULL,
  SRC_ORIG_STORE_NR             NUMBER(10,0)                  NULL,
  OVEN_ID                       NUMBER(38)                    NULL,
  OVEN_IP                       VARCHAR(20)                   NULL,
  OVEN_BRAND                    VARCHAR(20) COLLATE 'en-ci'   NULL,
  OVEN_ERROR_TMSP               TIMESTAMP_NTZ(6)              NULL,
  OVEN_ERROR_ID                 NUMBER(38)                    NULL,
  OVEN_ERROR_DESCR              VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_CAL_DT                    DATE                          NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);