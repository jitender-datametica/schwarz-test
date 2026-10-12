CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_2LIS_03_BF_2_ITEM_MOVEMENT_RECORD_2
(
  RECORD_ID                 NUMBER(10,0)                  NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  ITEM_MOVEMENT_RECORD_YEAR NUMBER(38)                    NULL,
  ITEM_MOVEMENT_RECORD_ID   NUMBER(20,0)                  NULL,
  DOC_DT                    DATE                          NULL,
  EVENT_TYPE_CD             VARCHAR(20)                   NULL,
  ACCT_REC_ENTRY_TMSP       TIMESTAMP_NTZ(6)              NULL,
  DWH_CAL_DT                DATE                          NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);