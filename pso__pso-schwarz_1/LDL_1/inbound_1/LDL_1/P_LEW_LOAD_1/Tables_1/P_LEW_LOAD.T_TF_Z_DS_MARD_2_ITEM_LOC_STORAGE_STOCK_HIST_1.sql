CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MARD_2_ITEM_LOC_STORAGE_STOCK_HIST_1
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_MARD_MATNR   VARCHAR(36)                   NOT NULL,
  Z_DS_MARD_WERKS   VARCHAR(8)                    NOT NULL,
  Z_DS_MARD_LGORT   VARCHAR(8)                    NOT NULL,
  SRC_MATNR         VARCHAR(40)                   NULL,
  SRC_WERKS         VARCHAR(40)                   NULL,
  STORAGE_LOC_CD    VARCHAR(20)                   NULL,
  FREE_QTY          NUMBER(18,5)                  NULL,
  MOV_QTY           NUMBER(18,5)                  NULL,
  QA_CHECK_QTY      NUMBER(18,5)                  NULL,
  BLOCKED_QTY       NUMBER(18,5)                  NULL,
  BLOCKED_BATCH_QTY NUMBER(18,5)                  NULL,
  DELETED_FG        NUMBER(38)                    NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);