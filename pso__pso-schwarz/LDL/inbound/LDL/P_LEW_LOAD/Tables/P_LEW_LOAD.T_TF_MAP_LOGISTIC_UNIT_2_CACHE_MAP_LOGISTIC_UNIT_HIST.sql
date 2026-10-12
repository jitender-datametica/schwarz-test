CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_LOGISTIC_UNIT_2_CACHE_MAP_LOGISTIC_UNIT_HIST
(
  CLIENT_ID                     NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  MAP_LOGISTIC_UNIT_BIC_ZMLILA  VARCHAR(3) COLLATE 'en-ci'    NULL,
  MAP_LOGISTIC_UNIT_UOM_ID      VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                    VARCHAR(60)                   NULL,
  UOM_ID                        VARCHAR(60)                   NULL,
  LOGISTIC_UNIT_CD              NUMBER(38,0)                  NULL,
  DELETED_FG                    NUMBER(38,0)                  NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);