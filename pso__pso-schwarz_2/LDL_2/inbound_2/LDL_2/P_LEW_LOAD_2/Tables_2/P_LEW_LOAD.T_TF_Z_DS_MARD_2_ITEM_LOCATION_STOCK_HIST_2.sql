CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MARD_2_ITEM_LOCATION_STOCK_HIST_2
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_MARD_MATNR   VARCHAR(36)                   NOT NULL,
  Z_DS_MARD_WERKS   VARCHAR(8)                    NOT NULL,
  SRC_MATNR         VARCHAR(40)                   NULL,
  SRC_WERKS         VARCHAR(40)                   NULL,
  SRC_SPACE_SWITCH  NUMBER(38)                    NOT NULL,
  PRICE             NUMBER(18,5)                  NULL,
  PRICE_NET         NUMBER(18,5)                  NULL,
  CALC_QTY          NUMBER(18,5)                  NULL,
  INV_QTY           NUMBER(18,5)                  NULL,
  DIFF_QTY_INV_CALC NUMBER(18,5)                  NULL,
  DELETED_FG        NUMBER(38)                    NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);