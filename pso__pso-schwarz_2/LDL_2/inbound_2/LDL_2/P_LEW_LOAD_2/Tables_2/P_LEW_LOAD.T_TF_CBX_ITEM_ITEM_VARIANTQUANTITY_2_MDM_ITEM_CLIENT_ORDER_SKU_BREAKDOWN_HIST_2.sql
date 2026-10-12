CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEM_VARIANTQUANTITY_2_MDM_ITEM_CLIENT_ORDER_SKU_BREAKDOWN_HIST_2
(
  CLIENT_ID                                                                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                                    VARCHAR(40)                   NULL,
  CBX_ITEM_ITEM_VARIANTQUANTITY_CBXITEM_DOCUMENTREF                               VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_VARIANTQUANTITY_CBXITEM_VARIANTQUANTITY_ITEMQUANTITY_COUNTRYCODE  VARCHAR(250)                  NULL,
  CBX_ITEM_ITEM_VARIANTQUANTITY_CBXITEM_VARIANTQUANTITY_ITEMSTYLE_UNIQUEIDS       VARCHAR(2000)                 NULL,
  CBX_ITEM_ITEM_VARIANTQUANTITY_CBXITEM_VARIANTQUANTITY_ITEMSIZE_CODE             VARCHAR(300)                  NULL,
  CBX_ITEM_ITEM_VARIANTQUANTITY_CBXITEM_VARIANTQUANTITY_ITEMLSV_CODE              VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                                                VARCHAR(40)                   NULL,
  CLIENT_ID_ORDER                                                                 NUMBER(38)                    NULL,
  SRC_STYLE_UNIQIDS_CD                                                            VARCHAR(2000)                 NULL,
  SRC_SIZE_CD                                                                     VARCHAR(300)                  NULL,
  SRC_VARIANT_CD                                                                  VARCHAR(250)                  NULL,
  ORDER_SKU_QTY                                                                   NUMBER(38)                    NULL,
  DELETED_FG                                                                      NUMBER(38)                    NULL,
  EXTRACTION_DT                                                                   DATE                          NULL,
  DWH_MAPPING_DT                                                                  DATE                          NULL,
  TF_ERROR_FG                                                                     NUMBER(1,0)                   NULL,
  RECORD_ID                                                                       NUMBER(10,0)                  NULL,
  FILENAME                                                                        VARCHAR(1000)                 NULL
);