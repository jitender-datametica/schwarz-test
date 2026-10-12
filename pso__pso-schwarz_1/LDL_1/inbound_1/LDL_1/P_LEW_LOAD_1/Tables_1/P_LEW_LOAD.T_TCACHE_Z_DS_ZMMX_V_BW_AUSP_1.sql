CREATE OR REPLACE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_Z_DS_ZMMX_V_BW_AUSP_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  BIC_ZMLILA        VARCHAR(10)                   NULL,
  ITEM_PROPERTY_SID NUMBER(10,0)                  NULL,
  OBJEK             VARCHAR(100)                  NULL,
  ATINN             NUMBER(10,0)                  NULL,
  ATWRT             VARCHAR(60)                   NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NOT NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NOT NULL
);