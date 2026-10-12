CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_MMO_ITEM_LOCATION_REPLENISHMENT_INFO_HIST_2
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LOC_SID                   NUMBER(38)                    NOT NULL,
  ITEM_SID                  NUMBER(38)                    NOT NULL,
  LOC_SID_WH                NUMBER(38)                    NULL,
  MAX_STOCK_UNIT_ID         NUMBER(38)                    NULL,
  MAX_STOCK_QTY             NUMBER(18,5)                  NULL,
  ORIENTATION_STOCK_UNIT_ID NUMBER(38)                    NULL,
  ORIENTATION_STOCK_QTY     NUMBER(18,5)                  NULL,
  ORDER_STOCK_UNIT_ID       NUMBER(38)                    NULL,
  ORDER_STOCK_QTY           NUMBER(18,5)                  NULL,
  MIN_ORDER_UNIT_ID         NUMBER(38)                    NULL,
  MIN_ORDER_QTY             NUMBER(18,5)                  NULL,
  EXTRACTION_DATE           DATE                          NOT NULL,
  DWH_LOAD_ID               NUMBER(38)                    NOT NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NOT NULL
);