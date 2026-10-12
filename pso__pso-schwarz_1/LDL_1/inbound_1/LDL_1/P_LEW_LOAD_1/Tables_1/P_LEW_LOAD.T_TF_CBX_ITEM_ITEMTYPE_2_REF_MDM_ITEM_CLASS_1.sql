CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMTYPE_2_REF_MDM_ITEM_CLASS_1
(
  CLIENT_ID                                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                                    VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMTYPE_CBXITEM_ITEMTYPE_CODE         VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMTYPE_CBXITEM_ITEMTYPE_NAME         VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMTYPE_CBXITEM_ITEMTYPE_DESCRIPTION  VARCHAR(250)                  NULL,
  ITEM_CLASS_CD                                   VARCHAR(20) COLLATE 'en-ci'   NULL,
  ITEM_CLASS                                      VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                   DATE                          NULL,
  DWH_MAPPING_DT                                  DATE                          NULL,
  TF_ERROR_FG                                     NUMBER(1,0)                   NULL,
  RECORD_ID                                       NUMBER(10,0)                  NULL,
  FILENAME                                        VARCHAR(1000)                 NULL
);