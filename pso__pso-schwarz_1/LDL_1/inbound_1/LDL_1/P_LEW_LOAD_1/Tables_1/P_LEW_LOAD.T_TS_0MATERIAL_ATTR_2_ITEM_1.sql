CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0MATERIAL_ATTR_2_ITEM_1
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  ITEM_SID            NUMBER(38)                    NULL,
  SRC_MATNR           VARCHAR(20)                   NULL,
  SRC_ORIG_ITEM_NR    VARCHAR(20)                   NULL,
  SRC_DAT_VALID_FROM  DATE                          NULL,
  SRC_CASE_SIZE       VARCHAR(20)                   NULL,
  ITEM_SID_CONFIG     NUMBER(38)                    NULL,
  ITEM_NAME           VARCHAR(100) COLLATE 'en-ci'  NULL,
  LOG_VAR_CD          VARCHAR(20)                   NULL,
  CONFIG_ITEM_CD      VARCHAR(20)                   NULL,
  ITEM_EKS_CD         VARCHAR(20)                   NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);