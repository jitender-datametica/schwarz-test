CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_MAST_STPO_2_ITEM_BOM_HIST_1
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  Z_DS_ZMMX_V_MAST_STPO_MATNR VARCHAR(36)                   NULL,
  Z_DS_ZMMX_V_MAST_STPO_WERKS VARCHAR(8)                    NULL,
  Z_DS_ZMMX_V_MAST_STPO_STLAN VARCHAR(2)                    NULL,
  Z_DS_ZMMX_V_MAST_STPO_STLNR VARCHAR(16)                   NULL,
  Z_DS_ZMMX_V_MAST_STPO_STLAL VARCHAR(4)                    NULL,
  SRC_MATNR                   VARCHAR(40)                   NULL,
  SRC_WERKS                   VARCHAR(40)                   NULL,
  SRC_STLNR                   VARCHAR(40)                   NULL,
  SRC_STLAN                   VARCHAR(40)                   NULL,
  SRC_STLAL                   VARCHAR(40)                   NULL,
  BOM_ALTERNATIVE_CD          VARCHAR(20)                   NULL,
  VERSION_COUNTER             NUMBER(38)                    NULL,
  ACTIVE_FROM_DT              DATE                          NULL,
  DELETED_FG                  NUMBER(38)                    NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);