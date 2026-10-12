CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_WH_MOVE_ACCOUNT_WAREHOUSE_1
(
  CONTEXT_LOAD_ID         NUMBER(38)                    NOT NULL,
  CONTEXT_COUNTRY         VARCHAR(20)                   NOT NULL,
  SRC_RECORD_ID           NUMBER(38)                    NOT NULL,
  CLIENT_ID               NUMBER(38)                    NOT NULL,
  LOC_SID_WH              NUMBER(38)                    NOT NULL,
  RECEIPT_ID              VARCHAR(100)                  NOT NULL,
  RECEIPT_TYPE_ID         NUMBER(38)                    NOT NULL,
  RECEIPT_TYPE_DESCR      VARCHAR(100)                  NULL,
  ACCOUNT_BALANCE_PAGE_NR NUMBER(38)                    NULL,
  LOC_SID_STORE           NUMBER(38)                    NULL,
  DEBIT_VAL               NUMBER(18,5)                  NULL,
  CREDIT_VAL              NUMBER(18,5)                  NULL,
  DAYEND_DT               DATE                          NOT NULL,
  DWH_CAL_DT              DATE                          NOT NULL,
  DWH_LOAD_ID             NUMBER(38)                    NOT NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NOT NULL
);