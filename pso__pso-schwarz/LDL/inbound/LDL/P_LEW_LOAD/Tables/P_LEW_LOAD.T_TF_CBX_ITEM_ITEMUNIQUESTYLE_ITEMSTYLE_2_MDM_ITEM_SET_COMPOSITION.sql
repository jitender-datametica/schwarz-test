CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMUNIQUESTYLE_ITEMSTYLE_2_MDM_ITEM_SET_COMPOSITION
(
  CLIENT_ID                                                                 NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                              VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMUNIQUESTYLE_ITEMSTYLE_CBXITEM_DOCUMENTREF                    VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMUNIQUESTYLE_ITEMSTYLE_CBXITEM_UNIQUESTYLE_ITEMSTYLEUNIQUEIDS VARCHAR(2000)                 NULL,
  CBX_ITEM_ITEMUNIQUESTYLE_ITEMSTYLE_CBXITEM_UNIQUESTYLE_ITEMSTYLE_UNIQUEID VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                                          VARCHAR(40)                   NULL,
  SRC_STYLE_UNIQIDS_CD                                                      VARCHAR(2000)                 NULL,
  SRC_STYLE_UNIQ_ID                                                         VARCHAR(400)                  NULL,
  STYLE_QTY                                                                 NUMBER(38)                    NULL,
  EXTRACTION_DT                                                             DATE                          NULL,
  DWH_MAPPING_DT                                                            DATE                          NULL,
  TF_ERROR_FG                                                               NUMBER(1,0)                   NULL,
  RECORD_ID                                                                 NUMBER(10,0)                  NULL,
  FILENAME                                                                  VARCHAR(1000)                 NULL
);