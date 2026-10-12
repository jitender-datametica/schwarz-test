CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_ITM_TYPE_2_CACHE_MAP_ITM_TYPE_HIST_1
(
  CLIENT_ID                 NUMBER(38,0)                  NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  MAP_ITM_TYPE_BIC_ZMLILA   VARCHAR(3) COLLATE 'en-ci'    NULL,
  MAP_ITM_TYPE_DESCR        VARCHAR(250) COLLATE 'en-ci'  NULL,
  MAP_ITM_TYPE_LIST_TYPE_CD VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                VARCHAR(60)                   NULL,
  DESCR                     VARCHAR(300)                  NULL,
  LIST_TYPE_CD              VARCHAR(60)                   NULL,
  BUYING_LIST_TYPE_ID       NUMBER(38,0)                  NULL,
  BUYING_LIST_TYPE_DESC     VARCHAR(300)                  NULL,
  DELETED_FG                NUMBER(38,0)                  NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);