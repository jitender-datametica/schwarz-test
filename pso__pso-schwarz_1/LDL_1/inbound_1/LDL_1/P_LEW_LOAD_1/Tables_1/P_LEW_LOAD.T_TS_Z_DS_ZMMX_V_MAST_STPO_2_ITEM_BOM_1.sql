CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZMMX_V_MAST_STPO_2_ITEM_BOM_1
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  ITEM_BOM_SID            NUMBER(38)                    NULL,
  SRC_MATNR               VARCHAR(20)                   NULL,
  SRC_WERKS               VARCHAR(20)                   NULL,
  SRC_STLNR               VARCHAR(20)                   NULL,
  SRC_STLAN               VARCHAR(20)                   NULL,
  SRC_STLAL               VARCHAR(20)                   NULL,
  ITEM_SID                NUMBER(38)                    NULL,
  BOM_ALTERNATIVE_CD_ACT  VARCHAR(20)                   NULL,
  VERSION_COUNTER_ACT     NUMBER(38)                    NULL,
  ACTIVE_FROM_DT_ACT      DATE                          NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);