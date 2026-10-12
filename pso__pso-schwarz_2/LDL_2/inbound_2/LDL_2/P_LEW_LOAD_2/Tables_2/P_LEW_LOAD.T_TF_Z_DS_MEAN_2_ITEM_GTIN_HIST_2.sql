CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MEAN_2_ITEM_GTIN_HIST_2
(
  CLIENT_ID       NUMBER(38)                    NULL,
  LIDL_COUNTRY    VARCHAR(40)                   NULL,
  Z_DS_MEAN_MATNR VARCHAR(36)                   NULL,
  Z_DS_MEAN_MEINH VARCHAR(6)                    NULL,
  Z_DS_MEAN_LFNUM VARCHAR(10)                   NULL,
  SRC_MATNR       VARCHAR(40)                   NULL,
  SRC_MSEHI       VARCHAR(40)                   NULL,
  SEQ_NR          VARCHAR(20)                   NULL,
  UOM_CD          VARCHAR(20)                   NULL,
  GTIN            VARCHAR(20)                   NULL,
  GTIN_TYPE_MARK  VARCHAR(20)                   NULL,
  GTIN_TYPE_LABEL VARCHAR(100)                  NULL,
  MAIN_GTIN_FG    NUMBER(38)                    NULL,
  DELETED_FG      NUMBER(38)                    NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000)                 NULL
);