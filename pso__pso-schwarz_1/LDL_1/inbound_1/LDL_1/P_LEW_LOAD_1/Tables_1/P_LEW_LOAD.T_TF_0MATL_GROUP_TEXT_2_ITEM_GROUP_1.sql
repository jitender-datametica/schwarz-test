CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0MATL_GROUP_TEXT_2_ITEM_GROUP_1
(
  CLIENT_ID             NUMBER(38)                    NULL,
  LIDL_COUNTRY          VARCHAR(40)                   NULL,
  MATL_GROUP_TEXT_KEY1  VARCHAR(120)                  NULL,
  SRC_MATKL             VARCHAR(20)                   NULL,
  SRC_WAWI_CD           VARCHAR(20)                   NULL,
  ITEM_GRP_NAME         VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000)                 NULL
);