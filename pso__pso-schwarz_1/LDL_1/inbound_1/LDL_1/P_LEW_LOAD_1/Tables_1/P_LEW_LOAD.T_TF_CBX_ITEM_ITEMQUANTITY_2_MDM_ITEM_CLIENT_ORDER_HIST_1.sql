CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMQUANTITY_2_MDM_ITEM_CLIENT_ORDER_HIST_1
(
  CLIENT_ID                                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                                            VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMQUANTITY_CBXITEM_DOCUMENTREF               VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMQUANTITY_CBXITEM_ITEMQUANTITY_COUNTRYCODE  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                        VARCHAR(40)                   NULL,
  CLIENT_ID_ORDER                                         NUMBER(38)                    NULL,
  CBX_ORDER_VERSION                                       NUMBER(38)                    NULL,
  CY_WEEK_ADVERTISE                                       NUMBER(38)                    NULL,
  CY_WEEK_IMPORT                                          NUMBER(38)                    NULL,
  CLIENT_SELL_FROM_DT                                     DATE                          NULL,
  CLIENT_SALE_PRICE                                       NUMBER(18,5)                  NULL,
  CLIENT_ORDER_CARTON_WEIGHT                              NUMBER(18,5)                  NULL,
  CLIENT_ORDER_TOTAL_QTY                                  NUMBER(38)                    NULL,
  CLIENT_ORDER_TOTAL_CARTON_QTY                           NUMBER(38)                    NULL,
  CLIENT_ORDER_NOTES                                      VARCHAR(300) COLLATE 'en-ci'  NULL,
  DELETED_FG                                              NUMBER(38)                    NULL,
  EXTRACTION_DT                                           DATE                          NULL,
  DWH_MAPPING_DT                                          DATE                          NULL,
  TF_ERROR_FG                                             NUMBER(1,0)                   NULL,
  RECORD_ID                                               NUMBER(10,0)                  NULL,
  FILENAME                                                VARCHAR(1000)                 NULL
);