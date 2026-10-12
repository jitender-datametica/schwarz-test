CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_ITM_MISSING_HIST2_0_2_ITEM_MISSING_PROGRESS_2
(
  CLIENT_ID                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  ITM_MISSING_HIST2_0_ZMMI_NO   VARCHAR(20)                   NOT NULL,
  ITM_MISSING_HIST2_0_ZMMI_POS  NUMBER(4,0)                   NOT NULL,
  ITEM_MISSING_ID               NUMBER(20,0)                  NULL,
  ITEM_MISSING_PROGRESS_ID      NUMBER(38)                    NULL,
  MISSING_ACTIVITY_CD           VARCHAR(20)                   NULL,
  MISSING_STATE_CD              VARCHAR(20)                   NULL,
  MISSING_STATE_PREV_CD         VARCHAR(20)                   NULL,
  MISSING_REASON_CD             VARCHAR(20)                   NULL,
  MISSING_REASON_PREV_CD        VARCHAR(20)                   NULL,
  CREATION_DTTM                 TIMESTAMP_NTZ(6)              NULL,
  CHANGE_DTTM                   TIMESTAMP_NTZ(6)              NULL,
  DWH_CAL_DT                    DATE                          NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);