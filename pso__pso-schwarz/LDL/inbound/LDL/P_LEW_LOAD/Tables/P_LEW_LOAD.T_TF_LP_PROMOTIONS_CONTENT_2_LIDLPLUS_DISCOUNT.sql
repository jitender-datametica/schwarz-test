CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_PROMOTIONS_CONTENT_2_LIDLPLUS_DISCOUNT
(
  CLIENT_ID                                 NUMBER(38)                    NULL,
  LIDL_COUNTRY                              VARCHAR(40)                   NULL,
  LP_PROMOTIONS_CONTENT_DISCOUNT_ID         NUMBER(38)                    NULL,
  LP_PROMOTIONS_CONTENT_VALIDITY_START_TMSP TIMESTAMP_NTZ(6)              NULL,
  LIDLPLUS_DISCOUNT_ID                      NUMBER(38)                    NULL,
  SRC_EXTERNAL_ID                           VARCHAR(100)                  NULL,
  STORE_ALL_FG                              NUMBER(38)                    NULL,
  PROMOTION_TYPE                            VARCHAR(100) COLLATE 'en-ci'  NULL,
  BENEFIT                                   VARCHAR(100) COLLATE 'en-ci'  NULL,
  BENEFIT_TYPE                              VARCHAR(100) COLLATE 'en-ci'  NULL,
  VALIDITY_START_TMSP                       TIMESTAMP_NTZ(6)              NULL,
  VALIDITY_END_TMSP                         TIMESTAMP_NTZ(6)              NULL,
  EXTRACTION_DT                             DATE                          NULL,
  DWH_MAPPING_DT                            DATE                          NULL,
  TF_ERROR_FG                               NUMBER(1,0)                   NULL,
  RECORD_ID                                 NUMBER(10,0)                  NULL,
  FILENAME                                  VARCHAR(1000)                 NULL
);