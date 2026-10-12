CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_OS_REL_2_ITEM_SORT_BOX_HIST_2
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  Z_DS_ZMMX_OS_REL_MATNR_HL VARCHAR(36)                   NULL,
  Z_DS_ZMMX_OS_REL_MATNR    VARCHAR(36)                   NULL,
  SRC_MATNR_SORT_BOX        VARCHAR(40)                   NULL,
  SRC_MATNR                 VARCHAR(40)                   NULL,
  DELETED_FG                NUMBER(38)                    NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);