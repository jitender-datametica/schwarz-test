CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_ITM_STORE_STOCK_HIST_2_ITEM_AGG_DAILY_MOVEMENT
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_SID        NUMBER(38)                    NULL,
  LOC_SID         NUMBER(38)                    NULL,
  STORAGE_LOC_CD  VARCHAR(20)                   NULL,
  INFLOW_QTY      NUMBER(18,5)                  NULL,
  OUTFLOW_QTY     NUMBER(18,5)                  NULL,
  DWH_CAL_DT      DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);