CREATE OR REPLACE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_Z_DS_ZMMX_V_BW_CAWN
(
  CLIENT_ID       NUMBER(38)                    NOT NULL,
  BIC_ZMLILA      VARCHAR(40) COLLATE 'en-ci'   NULL,
  ATWRT           VARCHAR(50) COLLATE 'en-ci'   NULL,
  ATINN           NUMBER(38)                    NOT NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NOT NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL
);