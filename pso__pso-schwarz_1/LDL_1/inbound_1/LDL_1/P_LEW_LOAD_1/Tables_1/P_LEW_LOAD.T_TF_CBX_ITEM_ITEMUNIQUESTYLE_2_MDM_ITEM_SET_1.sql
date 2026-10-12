CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMUNIQUESTYLE_2_MDM_ITEM_SET_1
(
  CLIENT_ID                                                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                    VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMUNIQUESTYLE_CBXITEM_DOCUMENTREF                    VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMUNIQUESTYLE_CBXITEM_UNIQUESTYLE_ITEMSTYLEUNIQUEIDS VARCHAR(2000)                 NULL,
  SRC_ITEM_DOC_REF                                                VARCHAR(20) COLLATE 'en-ci'   NULL,
  SRC_STYLE_UNIQIDS_CD                                            VARCHAR(2000) COLLATE 'en-ci' NULL,
  SET_CONTENT_QTY                                                 NUMBER(38)                    NULL,
  SET_MULTIPACK_FG                                                NUMBER(38)                    NULL,
  EXTRACTION_DT                                                   DATE                          NULL,
  DWH_MAPPING_DT                                                  DATE                          NULL,
  TF_ERROR_FG                                                     NUMBER(1,0)                   NULL,
  RECORD_ID                                                       NUMBER(10,0)                  NULL,
  FILENAME                                                        VARCHAR(1000)                 NULL
);