CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_2LIS_03_BF_2_ITEM_MOVEMENT_RECORD_1
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  LIS_03_BF_MBLNR           VARCHAR(20)                   NULL,
  LIS_03_BF_MJAHR           NUMBER(4,0)                   NULL,
  ITEM_MOVEMENT_RECORD_YEAR NUMBER(38)                    NULL,
  ITEM_MOVEMENT_RECORD_ID   NUMBER(20,0)                  NULL,
  DOC_DT                    DATE                          NULL,
  EVENT_TYPE_CD             VARCHAR(20)                   NULL,
  ACCT_REC_ENTRY_TMSP       TIMESTAMP_NTZ(6)              NULL,
  DWH_CAL_DT                DATE                          NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);