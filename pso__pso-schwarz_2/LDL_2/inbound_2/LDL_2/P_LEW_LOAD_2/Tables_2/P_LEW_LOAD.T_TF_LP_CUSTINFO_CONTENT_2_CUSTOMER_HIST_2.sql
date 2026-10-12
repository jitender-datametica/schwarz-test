CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_CUSTINFO_CONTENT_2_CUSTOMER_HIST_2
(
  CLIENT_ID                                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                                VARCHAR(40)                   NULL,
  LP_CUSTINFO_CONTENT_REGISTRATION_COUNTRY_CD VARCHAR(250)                  NULL,
  LP_CUSTINFO_CONTENT_HOME_COUNTRY_CD         VARCHAR(250)                  NULL,
  LP_CUSTINFO_CONTENT_CUSTOMER_ID             VARCHAR(250)                  NULL,
  SRC_CUSTOMERID                              VARCHAR(40)                   NULL,
  LIDLPLUS_REGISTRATION_DT                    DATE                          NULL,
  LIDLPLUS_UNREGISTRATION_DT                  DATE                          NULL,
  DELETED_FG                                  NUMBER(38)                    NULL,
  EXTRACTION_DT                               DATE                          NULL,
  DWH_MAPPING_DT                              DATE                          NULL,
  TF_ERROR_FG                                 NUMBER(1,0)                   NULL,
  RECORD_ID                                   NUMBER(10,0)                  NULL,
  FILENAME                                    VARCHAR(1000)                 NULL
);