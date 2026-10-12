CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_CONTINENTTYPE_2_MDM_MARKET_2
(
  CLIENT_ID                                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                                      VARCHAR(40)                   NULL,
  CBX_ITEM_CONTINENTTYPE_CBXITEM_CONTINENTTYPE_CODE VARCHAR(250)                  NULL,
  MARKET_CD                                         VARCHAR(20) COLLATE 'en-ci'   NULL,
  MARKET                                            VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                     DATE                          NULL,
  DWH_MAPPING_DT                                    DATE                          NULL,
  TF_ERROR_FG                                       NUMBER(1,0)                   NULL,
  RECORD_ID                                         NUMBER(10,0)                  NULL,
  FILENAME                                          VARCHAR(1000)                 NULL
);