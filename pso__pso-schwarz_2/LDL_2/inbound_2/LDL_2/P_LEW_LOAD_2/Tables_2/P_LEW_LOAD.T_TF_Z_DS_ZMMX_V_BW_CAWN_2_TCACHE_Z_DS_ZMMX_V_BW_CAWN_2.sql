CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_BW_CAWN_2_TCACHE_Z_DS_ZMMX_V_BW_CAWN_2
(
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(40) COLLATE 'en-ci'   NULL,
  ATWRT           VARCHAR(50) COLLATE 'en-ci'   NULL,
  ATINN           NUMBER(38)                    NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL
);