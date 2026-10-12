CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_APT_ITEM_PROMOTION_MEDIUM_2_ITEM_PROMOTION_MEDIUM
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  ITEM_SID                NUMBER(38)                    NULL,
  PROMOTION_DT            DATE                          NULL,
  ADVERTISING_MEDIUM_CD   VARCHAR(100) COLLATE 'en-ci'  NULL,
  ADVERTISING_MEDIUM_POS  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);