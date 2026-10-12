CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0COMP_CODE_ATTR_2_COMPANY_1
(
  CLIENT_ID             NUMBER(38)                    NULL,
  LIDL_COUNTRY          VARCHAR(40)                   NULL,
  COMP_CODE_ATTR_BUKRS  VARCHAR(8)                    NULL,
  SRC_BUKRS             VARCHAR(20)                   NULL,
  SRC_ADDRNUMBER        VARCHAR(40)                   NULL,
  COMP_NAME             VARCHAR(100) COLLATE 'en-ci'  NULL,
  CITY                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ACCOUNT_PLAN_CD       VARCHAR(20)                   NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000)                 NULL
);