CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_POS_CLEAN_AUDIT_2_POS_CTRL_AUDIT_1
(
  RECORD_ID         VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  LOC_SID           NUMBER(38)                    NULL,
  REGISTER_ID       NUMBER(38)                    NULL,
  CASHIER_ID        NUMBER(38)                    NULL,
  CASHIER_STATUS_ID NUMBER(38)                    NULL,
  AUDIT_TYPE_ID     NUMBER(38)                    NULL,
  AUDIT_NR          NUMBER(38)                    NULL,
  AUDIT_CNT         NUMBER(38)                    NULL,
  AUDIT_VAL         NUMBER(18,5)                  NULL,
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