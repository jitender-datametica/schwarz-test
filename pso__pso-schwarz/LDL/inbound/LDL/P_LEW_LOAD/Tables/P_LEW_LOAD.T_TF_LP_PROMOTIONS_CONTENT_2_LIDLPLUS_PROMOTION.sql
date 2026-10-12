CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_PROMOTIONS_CONTENT_2_LIDLPLUS_PROMOTION
(
  CLIENT_ID                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                      VARCHAR(40)                   NULL,
  LP_PROMOTIONS_CONTENT_EXTERNAL_ID VARCHAR(100)                  NULL,
  SRC_EXTERNAL_ID                   VARCHAR(100)                  NULL,
  EXTRACTION_DT                     DATE                          NULL,
  DWH_MAPPING_DT                    DATE                          NULL,
  TF_ERROR_FG                       NUMBER(1,0)                   NULL,
  RECORD_ID                         NUMBER(10,0)                  NULL,
  FILENAME                          VARCHAR(1000)                 NULL
);