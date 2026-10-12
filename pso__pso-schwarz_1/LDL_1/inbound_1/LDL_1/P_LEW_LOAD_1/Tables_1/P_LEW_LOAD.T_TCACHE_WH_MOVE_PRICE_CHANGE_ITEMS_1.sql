CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_WH_MOVE_PRICE_CHANGE_ITEMS_1
(
  CLIENT_ID                   NUMBER(38)                    NOT NULL,
  LOC_SID_STORE               NUMBER(38)                    NOT NULL,
  LOC_SID_WH                  NUMBER(38)                    NOT NULL,
  WH_ID                       NUMBER(38)                    NOT NULL,
  SUB_ITEM_GRP_SID            NUMBER(38)                    NULL,
  ITEM_SID                    NUMBER(38)                    NULL,
  ACCOUNT_ID                  NUMBER(38)                    NOT NULL,
  RECEIPT_TYPE_ID             NUMBER(38)                    NOT NULL,
  RECEIPT_TYPE_DESCR          VARCHAR(100) COLLATE 'en-ci'  NULL,
  PRICE_CHANGE_DEBIT_VAL      NUMBER(18,5)                  NULL,
  PRICE_CHANGE_DEBIT_NET_VAL  NUMBER(18,5)                  NULL,
  PRICE_CHANGE_CREDIT_VAL     NUMBER(18,5)                  NULL,
  PRICE_CHANGE_CREDIT_NET_VAL NUMBER(18,5)                  NULL,
  DAYEND_DT                   DATE                          NOT NULL,
  DWH_CAL_DT                  DATE                          NOT NULL,
  DWH_LOAD_ID                 NUMBER(38)                    NOT NULL,
  EXTRACTION_TS               TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_CREATED                 TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED                 TIMESTAMP_NTZ(6)              NOT NULL
);