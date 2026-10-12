CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_ITM_STATE_2_CACHE_MAP_ITM_STATE_HIST_1
(
  CLIENT_ID                       NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  MAP_ITM_STATE_BIC_ZMLILA        VARCHAR(3) COLLATE 'en-ci'    NULL,
  MAP_ITM_STATE_ITM_STATE_BGES_ID VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                      VARCHAR(60)                   NULL,
  ITM_STATE_BGES_ID               VARCHAR(60)                   NULL,
  ITM_STATE_DESCR                 VARCHAR(300)                  NULL,
  MIS_ITM_STATE_ID                NUMBER(38,0)                  NULL,
  MIS_STATE_DESCR                 VARCHAR(3000)                 NULL,
  DELETED_FG                      NUMBER(38,0)                  NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);