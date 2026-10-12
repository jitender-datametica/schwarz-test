CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_COUNTRYORDERSTATUS_2_REF_MDM_BUY_STATUS
(
  CLIENT_ID                                                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                VARCHAR(40)                   NULL,
  CBX_ITEM_COUNTRYORDERSTATUS_CBXITEM_COUNTRYORDERSTATUS_CODE VARCHAR(250)                  NULL,
  BUY_STATUS_CD                                               VARCHAR(20) COLLATE 'en-ci'   NULL,
  BUY_STATUS                                                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUY_STATUS_DESCR                                            VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                               DATE                          NULL,
  DWH_MAPPING_DT                                              DATE                          NULL,
  TF_ERROR_FG                                                 NUMBER(1,0)                   NULL,
  RECORD_ID                                                   NUMBER(10,0)                  NULL,
  FILENAME                                                    VARCHAR(1000)                 NULL
);