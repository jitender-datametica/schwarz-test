CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0MATL_TYPE_TEXT_2_ITEM_TYPE_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_TYPE_SID   NUMBER(38)                    NULL,
  SRC_MTART       VARCHAR(20)                   NULL,
  ITEM_TYPE_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);