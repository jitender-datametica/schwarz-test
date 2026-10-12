CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMLSV_COUNTRYCODES_2_MDM_ITEM_VARIANT_CLIENT_HIST_2
(
  CLIENT_ID                                                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                            VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMLSV_COUNTRYCODES_CBXITEM_DOCUMENTREF                       VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMLSV_COUNTRYCODES_CBXITEM_ITEMLSV_CODE                      VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMLSV_COUNTRYCODES_CBXITEM_ITEMLSV_COUNTRYCODES_COUNTRYCODE  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                                        VARCHAR(40)                   NULL,
  SRC_VARIANT_CD                                                          VARCHAR(250)                  NULL,
  CLIENT_ID_RECIPIENT                                                     NUMBER(38)                    NULL,
  CLIENT_BLOCK_ID                                                         NUMBER(38)                    NULL,
  DELETED_FG                                                              NUMBER(38)                    NULL,
  EXTRACTION_DT                                                           DATE                          NULL,
  DWH_MAPPING_DT                                                          DATE                          NULL,
  TF_ERROR_FG                                                             NUMBER(1,0)                   NULL,
  RECORD_ID                                                               NUMBER(10,0)                  NULL,
  FILENAME                                                                VARCHAR(1000)                 NULL
);