CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_MAP_MOV_TYPE_2_CACHE_MAP_MOV_TYPE_HIST_2
(
  CLIENT_ID                   NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  MAP_MOV_TYPE_BIC_ZMLILA     VARCHAR(3) COLLATE 'en-ci'    NULL,
  MAP_MOV_TYPE_MOV_TYPE_CD    VARCHAR(250) COLLATE 'en-ci'  NULL,
  MAP_MOV_TYPE_MOV_REASON_CD  VARCHAR(250) COLLATE 'en-ci'  NULL,
  MAP_MOV_TYPE_LOC_TYPE_CD    VARCHAR(250) COLLATE 'en-ci'  NULL,
  BIC_ZMLILA                  VARCHAR(60)                   NULL,
  MOV_TYPE_CD                 VARCHAR(60)                   NULL,
  MOV_REASON_CD               VARCHAR(60)                   NULL,
  MOV_TYPE_DESCR              VARCHAR(300)                  NULL,
  LOC_TYPE_CD                 VARCHAR(60)                   NULL,
  LOC_TYPE_DESCR              VARCHAR(300)                  NULL,
  MIS_SFO_TYPE_ID             NUMBER(38,0)                  NULL,
  MIS_SFO_TYPE_DESCR          VARCHAR(300)                  NULL,
  MAP_USE_CD                  VARCHAR(60)                   NULL,
  DELETED_FG                  NUMBER(38,0)                  NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);