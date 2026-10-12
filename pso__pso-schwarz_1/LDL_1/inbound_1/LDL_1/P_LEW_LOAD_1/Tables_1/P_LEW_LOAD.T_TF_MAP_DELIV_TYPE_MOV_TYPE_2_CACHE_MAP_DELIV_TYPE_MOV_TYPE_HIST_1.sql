CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_DELIV_TYPE_MOV_TYPE_2_CACHE_MAP_DELIV_TYPE_MOV_TYPE_HIST_1
(
  CLIENT_ID                             NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NULL,
  MAP_DELIV_TYPE_MOV_TYPE_BIC_ZMLILA    VARCHAR(3) COLLATE 'en-ci'    NULL,
  MAP_DELIV_TYPE_MOV_TYPE_ORDER_TYPE_CD VARCHAR(250) COLLATE 'en-ci'  NULL,
  MAP_DELIV_TYPE_MOV_TYPE_MOV_TYPE_CD   VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                            VARCHAR(60)                   NULL,
  ORDER_TYPE_CD                         VARCHAR(60)                   NULL,
  MOV_TYPE_CD                           VARCHAR(60)                   NULL,
  DELIV_TYPE_CD                         NUMBER(38,0)                  NULL,
  DELETED_FG                            NUMBER(38,0)                  NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             NUMBER(10,0)                  NULL,
  FILENAME                              VARCHAR(1000)                 NULL
);