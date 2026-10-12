CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0SALESORG_ATTR_2_SALES_ORG_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  SALESORG_ATTR_VKORG VARCHAR(8)                    NULL,
  SRC_VKORG           VARCHAR(20)                   NULL,
  SALES_ORG_NAME      VARCHAR(100) COLLATE 'en-ci'  NULL,
  SRC_BUKRS           VARCHAR(40)                   NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);