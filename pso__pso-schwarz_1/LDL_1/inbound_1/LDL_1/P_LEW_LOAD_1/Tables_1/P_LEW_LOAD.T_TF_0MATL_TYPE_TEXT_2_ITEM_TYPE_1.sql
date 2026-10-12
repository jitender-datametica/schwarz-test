CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0MATL_TYPE_TEXT_2_ITEM_TYPE_1
(
  CLIENT_ID             NUMBER(38)                    NULL,
  LIDL_COUNTRY          VARCHAR(40)                   NULL,
  MATL_TYPE_TEXT_KEY1   VARCHAR(120)                  NULL,
  MATL_TYPE_TEXT_LANGU  VARCHAR(4)                    NULL,
  SRC_MTART             VARCHAR(20)                   NULL,
  ITEM_TYPE_NAME        VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000)                 NULL
);