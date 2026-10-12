CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0RT_WRF3_ATTR_2_STORE_TO_WH_DELIVERY_HIST
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  LOC_SID_STORE   NUMBER(38)                    NULL,
  LOC_SID_WH      NUMBER(38)                    NULL,
  ITEM_GRP_SID    NUMBER(38)                    NULL,
  ITEM_GRP_CD     VARCHAR(20)                   NULL,
  PRIORITY        NUMBER(38)                    NULL,
  ACTIVE_FROM_DT  DATE                          NULL,
  ACTIVE_TO_DT    DATE                          NULL,
  DELETED_FG      NUMBER(38)                    NULL,
  DWH_VALID_FROM  DATE                          NULL,
  DWH_VALID_TO    DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);