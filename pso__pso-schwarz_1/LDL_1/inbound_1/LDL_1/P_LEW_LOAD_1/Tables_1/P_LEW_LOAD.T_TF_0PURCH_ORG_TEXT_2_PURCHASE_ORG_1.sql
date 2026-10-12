CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0PURCH_ORG_TEXT_2_PURCHASE_ORG_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  PURCH_ORG_TEXT_KEY1 VARCHAR(120)                  NULL,
  SRC_EKORG           VARCHAR(20)                   NULL,
  PUR_ORG_NAME        VARCHAR(100) COLLATE 'en-ci'  NULL,
  SRC_BUKRS           VARCHAR(40)                   NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);