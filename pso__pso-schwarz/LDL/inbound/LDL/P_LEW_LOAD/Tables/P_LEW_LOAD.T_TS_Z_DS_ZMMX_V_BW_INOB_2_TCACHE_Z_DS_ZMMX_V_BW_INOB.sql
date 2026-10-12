CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZMMX_V_BW_INOB_2_TCACHE_Z_DS_ZMMX_V_BW_INOB
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  BIC_ZMLILA      VARCHAR(10)                   NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_SID        NUMBER(20,0)                  NULL,
  OBJEK           VARCHAR(100)                  NULL,
  CUOBJ           VARCHAR(100)                  NULL,
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