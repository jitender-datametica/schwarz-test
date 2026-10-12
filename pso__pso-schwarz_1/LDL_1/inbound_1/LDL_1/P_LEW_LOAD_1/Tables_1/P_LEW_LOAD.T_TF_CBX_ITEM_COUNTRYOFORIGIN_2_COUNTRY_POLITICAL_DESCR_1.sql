CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_COUNTRYOFORIGIN_2_COUNTRY_POLITICAL_DESCR_1
(
  CLIENT_ID                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                          VARCHAR(40)                   NULL,
  CBX_ITEM_COUNTRYOFORIGIN_CBXITEM_COUNTRYOFORIGIN_CODE VARCHAR(250)                  NULL,
  SRC_LAND1                                             VARCHAR(40)                   NULL,
  LANG_CD                                               VARCHAR(20)                   NULL,
  COUNTRY_POL_DESCR                                     VARCHAR(100) COLLATE 'en-ci'  NULL,
  NATIONALITY                                           VARCHAR(300) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                         DATE                          NULL,
  DWH_MAPPING_DT                                        DATE                          NULL,
  TF_ERROR_FG                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                             NUMBER(10,0)                  NULL,
  FILENAME                                              VARCHAR(1000)                 NULL
);