CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_PCWO_ID_2_CACHE_MAP_PCWO_ID_HIST_1
(
  CLIENT_ID                 NUMBER(38,0)                  NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  MAP_PCWO_ID_MOV_TYPE_CD   VARCHAR(250) COLLATE 'en-ci'  NULL,
  MAP_PCWO_ID_MOV_REASON_CD VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                VARCHAR(60)                   NULL,
  PCWO_REASON_ID            NUMBER(38,0)                  NULL,
  MOV_TYPE_CD               VARCHAR(60)                   NULL,
  MOV_REASON_CD             VARCHAR(60)                   NULL,
  MOV_REASON_DESCR          VARCHAR(300)                  NULL,
  DELETED_FG                NUMBER(38,0)                  NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);