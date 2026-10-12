CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_MARC_LIST_2_ITEM_LISTING_TYPE_HIST_2
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  Z_DS_ZMMX_MARC_LIST_MATNR VARCHAR(36)                   NULL,
  Z_DS_ZMMX_MARC_LIST_WERKS VARCHAR(8)                    NULL,
  SRC_MATNR                 VARCHAR(40)                   NULL,
  SRC_WERKS                 VARCHAR(40)                   NULL,
  ACTIVE_FROM_DT            DATE                          NULL,
  ACTIVE_TO_DT              DATE                          NULL,
  LIST_TYPE_MARK            VARCHAR(20)                   NULL,
  LIST_TYPE_LABEL           VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG                NUMBER(38)                    NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);