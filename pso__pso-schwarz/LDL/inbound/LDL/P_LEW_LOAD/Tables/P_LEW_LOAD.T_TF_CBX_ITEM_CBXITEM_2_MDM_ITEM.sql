CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_CBXITEM_2_MDM_ITEM
(
  CLIENT_ID                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  CBX_ITEM_CBXITEM_DOCUMENTREF  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF              VARCHAR(20) COLLATE 'en-ci'   NULL,
  MDM_ITEM_NAME                 VARCHAR(100)                  NULL,
  ITEM_IAN                      NUMBER(38)                    NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);