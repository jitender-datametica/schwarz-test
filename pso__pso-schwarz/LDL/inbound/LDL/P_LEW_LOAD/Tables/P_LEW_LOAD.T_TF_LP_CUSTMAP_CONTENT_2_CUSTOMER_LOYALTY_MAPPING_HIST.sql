CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_CUSTMAP_CONTENT_2_CUSTOMER_LOYALTY_MAPPING_HIST
(
  CLIENT_ID                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  LP_CUSTMAP_CONTENT_CUSTOMER_ID  VARCHAR(250)                  NULL,
  LP_CUSTMAP_CONTENT_LOYALTY_CD   VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_CUSTOMERID                  VARCHAR(40)                   NULL,
  LOYALTY_CD                      VARCHAR(100) COLLATE 'en-ci'  NULL,
  IDENT_TYPE_CD                   VARCHAR(20) COLLATE 'en-ci'   NULL,
  MAPPING_START_TMSP              TIMESTAMP_NTZ(6)              NULL,
  MAPPING_END_TMSP                TIMESTAMP_NTZ(6)              NULL,
  DELETED_FG                      NUMBER(38)                    NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);