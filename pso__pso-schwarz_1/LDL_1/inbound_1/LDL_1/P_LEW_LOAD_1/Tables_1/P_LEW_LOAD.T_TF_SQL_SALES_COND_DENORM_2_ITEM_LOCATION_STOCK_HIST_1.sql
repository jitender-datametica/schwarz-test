CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_SALES_COND_DENORM_2_ITEM_LOCATION_STOCK_HIST_1
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  ITEM_SID          NUMBER(38)                    NOT NULL,
  LOC_SID           NUMBER(38)                    NOT NULL,
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