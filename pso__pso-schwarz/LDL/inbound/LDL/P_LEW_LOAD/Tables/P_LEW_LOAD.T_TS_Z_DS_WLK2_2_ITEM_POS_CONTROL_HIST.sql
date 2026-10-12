CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_WLK2_2_ITEM_POS_CONTROL_HIST
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  ITEM_SID                NUMBER(38)                    NULL,
  SALES_ORG_SID           NUMBER(38)                    NULL,
  LOC_SID                 NUMBER(38)                    NULL,
  DISTRIBUTION_CHANNEL_CD VARCHAR(20)                   NULL,
  SCALE_AREA              VARCHAR(20)                   NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  DWH_VALID_FROM          DATE                          NULL,
  DWH_VALID_TO            DATE                          NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);