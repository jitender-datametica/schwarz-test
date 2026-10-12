CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_ITM_STORE_STOCK_HIST2_0_2_ITEM_AGG_DAILY_MOVEMENT
(
  CLIENT_ID                         NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                      VARCHAR(40)                   NOT NULL,
  ITM_STORE_STOCK_HIST2_0_STOR_LOC  VARCHAR(8)                    NOT NULL,
  ITM_STORE_STOCK_HIST2_0_PLANT     VARCHAR(8)                    NOT NULL,
  ITM_STORE_STOCK_HIST2_0_MATERIAL  VARCHAR(36)                   NOT NULL,
  ITM_STORE_STOCK_HIST2_0_CALDAY    DATE                          NOT NULL,
  SRC_MATNR                         VARCHAR(40)                   NULL,
  SRC_WERKS                         VARCHAR(40)                   NULL,
  STORAGE_LOC_CD                    VARCHAR(20)                   NOT NULL,
  INFLOW_QTY                        NUMBER(18,5)                  NULL,
  OUTFLOW_QTY                       NUMBER(18,5)                  NULL,
  DWH_CAL_DT                        DATE                          NOT NULL,
  EXTRACTION_DT                     DATE                          NULL,
  DWH_MAPPING_DT                    DATE                          NOT NULL,
  TF_ERROR_FG                       NUMBER(1,0)                   NULL,
  RECORD_ID                         VARCHAR(300)                  NOT NULL,
  FILENAME                          VARCHAR(1000)                 NOT NULL
);