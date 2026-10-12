CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_POS_CLEAN_TAX_LIST_2_POS_CTRL_TAX_LIST
(
  RECORD_ID         VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  LOC_SID           NUMBER(38)                    NULL,
  REGISTER_ID       NUMBER(38)                    NULL,
  CASHIER_ID        NUMBER(38)                    NULL,
  CASHIER_STATUS_ID NUMBER(38)                    NULL,
  AUDIT_NR          NUMBER(38)                    NULL,
  TAX_CLASS_CD      VARCHAR(20)                   NULL,
  TAX_CLASS_CHAR_CD VARCHAR(20)                   NULL,
  TAX_CLASS_RATE    NUMBER(18,5)                  NULL,
  TAX_VAL           NUMBER(18,5)                  NULL,
  TAX_TOTAL_VAL     NUMBER(18,5)                  NULL,
  DWH_CAL_DT        DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);