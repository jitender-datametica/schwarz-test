CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMQUANTITY_2_MDM_ITEM_CLIENT_ORDER
(
  CLIENT_ID                                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                                            VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMQUANTITY_CBXITEM_DOCUMENTREF               VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMQUANTITY_CBXITEM_ITEMQUANTITY_COUNTRYCODE  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                        VARCHAR(40)                   NULL,
  CLIENT_ID_ORDER                                         NUMBER(38)                    NULL,
  CLIENT_CD                                               VARCHAR(20) COLLATE 'en-ci'   NULL,
  CLIENT_BLOCK_ID_ORDER                                   NUMBER(38)                    NULL,
  EXTRACTION_DT                                           DATE                          NULL,
  DWH_MAPPING_DT                                          DATE                          NULL,
  TF_ERROR_FG                                             NUMBER(1,0)                   NULL,
  RECORD_ID                                               NUMBER(10,0)                  NULL,
  FILENAME                                                VARCHAR(1000)                 NULL
);