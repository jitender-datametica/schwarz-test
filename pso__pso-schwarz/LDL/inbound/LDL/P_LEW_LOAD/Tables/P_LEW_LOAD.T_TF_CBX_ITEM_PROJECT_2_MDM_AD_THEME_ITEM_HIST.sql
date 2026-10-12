CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_PROJECT_2_MDM_AD_THEME_ITEM_HIST
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_ITEM_PROJECT_CBXITEM_DOCUMENTREF          VARCHAR(250)                  NULL,
  CBX_ITEM_PROJECT_CBXITEM_PROJECT_DOCUMENTREF  VARCHAR(250)                  NULL,
  SRC_PROJ_DOC_REF                              VARCHAR(40)                   NULL,
  SRC_ITEM_DOC_REF                              VARCHAR(40)                   NULL,
  DELETED_FG                                    NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);