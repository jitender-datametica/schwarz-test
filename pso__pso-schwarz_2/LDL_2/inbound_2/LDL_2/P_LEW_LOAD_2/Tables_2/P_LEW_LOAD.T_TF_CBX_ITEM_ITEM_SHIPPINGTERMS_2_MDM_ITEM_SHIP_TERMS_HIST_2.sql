CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEM_SHIPPINGTERMS_2_MDM_ITEM_SHIP_TERMS_HIST_2
(
  CLIENT_ID                                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                          VARCHAR(40)                   NULL,
  CBX_ITEM_ITEM_SHIPPINGTERMS_CBXITEM_DOCUMENTREF                       VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_SHIPPINGTERMS_CBXITEM_SHIPPINGTERMS_MARKET              VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_SHIPPINGTERMS_CBXITEM_SHIPPINGTERMS_INVOICECURRENCY     VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_SHIPPINGTERMS_CBXITEM_SHIPPINGTERMS_COMPLETIONTYPE_CODE VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_SHIPPINGTERMS_CBXITEM_SHIPPINGTERMS_INCOTERMS_CODE      VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                                      VARCHAR(40)                   NULL,
  MARKET_CD                                                             VARCHAR(40)                   NULL,
  SRC_COMPLETION_TYPE_CD                                                VARCHAR(40)                   NULL,
  SRC_INCOTERMS_CD                                                      VARCHAR(40)                   NULL,
  CURR_CD_INVOICE                                                       VARCHAR(40)                   NULL,
  DELETED_FG                                                            NUMBER(38)                    NULL,
  EXTRACTION_DT                                                         DATE                          NULL,
  DWH_MAPPING_DT                                                        DATE                          NULL,
  TF_ERROR_FG                                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                                             NUMBER(10,0)                  NULL,
  FILENAME                                                              VARCHAR(1000)                 NULL
);