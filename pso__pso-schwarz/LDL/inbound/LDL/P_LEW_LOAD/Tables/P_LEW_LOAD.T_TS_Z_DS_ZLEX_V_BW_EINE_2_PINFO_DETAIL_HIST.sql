CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZLEX_V_BW_EINE_2_PINFO_DETAIL_HIST
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  PINFO_SID       NUMBER(38)                    NULL,
  LOC_SID         NUMBER(38)                    NULL,
  PUR_ORG_SID     NUMBER(38)                    NULL,
  BRAND_SID       NUMBER(38)                    NULL,
  PINFO_TYPE_CD   VARCHAR(20)                   NULL,
  INCOTERM_1      VARCHAR(20)                   NULL,
  INCOTERM_2      VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG      NUMBER(38)                    NULL,
  DWH_VALID_FROM  DATE                          NULL,
  DWH_VALID_TO    DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);