CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_MIS_ITEMS_2_ITEM_MISSING
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_MISSING_ID NUMBER(20,0)                  NULL,
  ITEM_SID        NUMBER(38)                    NULL,
  LOC_SID         NUMBER(38)                    NULL,
  STORAGE_LOC_CD  VARCHAR(20)                   NULL,
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