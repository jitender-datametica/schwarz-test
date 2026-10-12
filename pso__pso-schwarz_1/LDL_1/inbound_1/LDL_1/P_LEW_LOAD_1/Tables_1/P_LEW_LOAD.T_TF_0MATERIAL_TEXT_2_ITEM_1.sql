CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0MATERIAL_TEXT_2_ITEM_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  MATERIAL_TEXT_MATNR VARCHAR(36)                   NULL,
  MATERIAL_TEXT_SPRAS VARCHAR(4)                    NULL,
  SRC_MATNR           VARCHAR(20)                   NULL,
  SRC_ORIG_ITEM_NR    VARCHAR(20)                   NULL,
  SRC_DAT_VALID_FROM  DATE                          NULL,
  SRC_CASE_SIZE       VARCHAR(20)                   NULL,
  SRC_MATNR_CONFIG    VARCHAR(40)                   NULL,
  ITEM_NAME           VARCHAR(100) COLLATE 'en-ci'  NULL,
  LOG_VAR_CD          VARCHAR(20)                   NULL,
  CONFIG_ITEM_CD      VARCHAR(20)                   NULL,
  ITEM_EKS_CD         VARCHAR(20)                   NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);