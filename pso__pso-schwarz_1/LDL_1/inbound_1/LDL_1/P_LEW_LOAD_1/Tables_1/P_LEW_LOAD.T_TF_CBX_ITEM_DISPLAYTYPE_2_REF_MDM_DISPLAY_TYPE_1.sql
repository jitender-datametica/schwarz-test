CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_DISPLAYTYPE_2_REF_MDM_DISPLAY_TYPE_1
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_ITEM_DISPLAYTYPE_CBXITEM_DISPLAYTYPE_CODE VARCHAR(250)                  NULL,
  DISPLAY_TYPE_CD                               VARCHAR(20) COLLATE 'en-ci'   NULL,
  DISPLAY_TYPE                                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);