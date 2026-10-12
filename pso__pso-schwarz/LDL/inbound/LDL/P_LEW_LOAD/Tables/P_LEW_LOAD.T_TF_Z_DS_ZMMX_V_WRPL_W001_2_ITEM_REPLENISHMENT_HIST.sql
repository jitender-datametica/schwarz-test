CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_WRPL_W001_2_ITEM_REPLENISHMENT_HIST
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  Z_DS_ZMMX_V_WRPL_W001_WERKS VARCHAR(8)                    NULL,
  Z_DS_ZMMX_V_WRPL_W001_KUNNR VARCHAR(20)                   NULL,
  Z_DS_ZMMX_V_WRPL_W001_MATNR VARCHAR(36)                   NULL,
  SRC_MATNR                   VARCHAR(40)                   NULL,
  SRC_WERKS                   VARCHAR(40)                   NULL,
  MIN_NOMINAL_STOCK           NUMBER(18,5)                  NULL,
  MIN_ORDER_QTY               NUMBER(18,5)                  NULL,
  DELETED_FG                  NUMBER(38)                    NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);