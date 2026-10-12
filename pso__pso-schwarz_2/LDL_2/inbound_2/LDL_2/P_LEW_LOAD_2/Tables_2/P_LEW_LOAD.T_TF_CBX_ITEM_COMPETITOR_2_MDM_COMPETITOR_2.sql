CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_COMPETITOR_2_MDM_COMPETITOR_2
(
  CLIENT_ID                                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                                VARCHAR(40)                   NULL,
  CBX_ITEM_COMPETITOR_CBXITEM_COMPETITOR_CODE VARCHAR(250)                  NULL,
  SRC_COMPETITOR_CD                           VARCHAR(20) COLLATE 'en-ci'   NULL,
  COMPETITOR_NAME                             VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                               DATE                          NULL,
  DWH_MAPPING_DT                              DATE                          NULL,
  TF_ERROR_FG                                 NUMBER(1,0)                   NULL,
  RECORD_ID                                   NUMBER(10,0)                  NULL,
  FILENAME                                    VARCHAR(1000)                 NULL
);