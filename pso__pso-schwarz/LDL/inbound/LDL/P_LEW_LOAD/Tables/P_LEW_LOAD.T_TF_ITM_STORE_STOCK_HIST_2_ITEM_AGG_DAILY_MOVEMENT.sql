CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_ITM_STORE_STOCK_HIST_2_ITEM_AGG_DAILY_MOVEMENT
(
  CLIENT_ID                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  ITM_STORE_STOCK_HIST_MATERIAL VARCHAR(36)                   NULL,
  ITM_STORE_STOCK_HIST_PLANT    VARCHAR(8)                    NULL,
  ITM_STORE_STOCK_HIST_STOR_LOC VARCHAR(8)                    NULL,
  SRC_MATNR                     VARCHAR(40)                   NULL,
  SRC_WERKS                     VARCHAR(40)                   NULL,
  STORAGE_LOC_CD                VARCHAR(20)                   NULL,
  INFLOW_QTY                    NUMBER(18,5)                  NULL,
  OUTFLOW_QTY                   NUMBER(18,5)                  NULL,
  DWH_CAL_DT                    DATE                          NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);