CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_CUSTINFO_CONTENT_2_CUSTOMER
(
  CLIENT_ID                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  LP_CUSTINFO_CONTENT_CUSTOMER_ID VARCHAR(250)                  NULL,
  SRC_CUSTOMERID                  VARCHAR(20)                   NULL,
  LIDLPLUS_CUSTOMER_CD            VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);