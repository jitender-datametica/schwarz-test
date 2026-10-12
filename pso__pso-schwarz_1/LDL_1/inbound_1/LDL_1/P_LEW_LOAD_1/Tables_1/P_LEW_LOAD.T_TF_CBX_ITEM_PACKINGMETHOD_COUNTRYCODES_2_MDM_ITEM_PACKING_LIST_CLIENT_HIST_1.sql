CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_PACKINGMETHOD_COUNTRYCODES_2_MDM_ITEM_PACKING_LIST_CLIENT_HIST_1
(
  CLIENT_ID                                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                          VARCHAR(40)                   NULL,
  CBX_ITEM_PACKINGMETHOD_COUNTRYCODES_CBXITEM_DOCUMENTREF               VARCHAR(250)                  NULL,
  CBX_ITEM_PACKINGMETHOD_COUNTRYCODES_CBXITEM_PACKINGMETHOD_CODE        VARCHAR(250)                  NULL,
  CBX_ITEM_PACKINGMETHOD_COUNTRYCODES_CBXITEM_PACKINGMETHOD_COUNTRYCODE VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                                      VARCHAR(40)                   NULL,
  SRC_PACK_METHOD_CD                                                    VARCHAR(40)                   NULL,
  CLIENT_ID_RECIPIENT                                                   NUMBER(38)                    NULL,
  COUNTRY_CD                                                            VARCHAR(20) COLLATE 'en-ci'   NULL,
  CLIENT_BLOCK_ID_RECIPIENT                                             NUMBER(38)                    NULL,
  DELETED_FG                                                            NUMBER(38)                    NULL,
  EXTRACTION_DT                                                         DATE                          NULL,
  DWH_MAPPING_DT                                                        DATE                          NULL,
  TF_ERROR_FG                                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                                             NUMBER(10,0)                  NULL,
  FILENAME                                                              VARCHAR(1000)                 NULL
);