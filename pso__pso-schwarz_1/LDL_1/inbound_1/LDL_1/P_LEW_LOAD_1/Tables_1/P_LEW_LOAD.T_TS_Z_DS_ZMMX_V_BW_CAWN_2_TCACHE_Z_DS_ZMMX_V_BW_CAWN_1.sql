CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZMMX_V_BW_CAWN_2_TCACHE_Z_DS_ZMMX_V_BW_CAWN_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(40) COLLATE 'en-ci'   NULL,
  ATWRT           VARCHAR(50) COLLATE 'en-ci'   NULL,
  ATINN           NUMBER(38)                    NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);