CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_RELATEDITEM_2_MDM_ITEM_RELATED_ITEM_HIST_1
(
  CLIENT_ID                                                 NUMBER(38)                    NULL,
  LIDL_COUNTRY                                              VARCHAR(40)                   NULL,
  CBX_ITEM_RELATEDITEM_CBXITEM_DOCUMENTREF                  VARCHAR(250)                  NULL,
  CBX_ITEM_RELATEDITEM_CBXITEM_RELATEDITEM_RELATEDITEMTYPE  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                          VARCHAR(40)                   NULL,
  ITEM_REL_TYPE_CD                                          VARCHAR(20) COLLATE 'en-ci'   NULL,
  SRC_ITEM_DOC_REF_RELATED                                  VARCHAR(40)                   NULL,
  DELETED_FG                                                NUMBER(38)                    NULL,
  EXTRACTION_DT                                             DATE                          NULL,
  DWH_MAPPING_DT                                            DATE                          NULL,
  TF_ERROR_FG                                               NUMBER(1,0)                   NULL,
  RECORD_ID                                                 NUMBER(10,0)                  NULL,
  FILENAME                                                  VARCHAR(1000)                 NULL
);