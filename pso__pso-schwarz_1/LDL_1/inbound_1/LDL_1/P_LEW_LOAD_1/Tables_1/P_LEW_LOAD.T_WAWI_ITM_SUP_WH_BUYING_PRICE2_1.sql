CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_SUP_WH_BUYING_PRICE2_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  WH_ID             NUMBER(38)                    NOT NULL,
  ITEM_ID           NUMBER(38)                    NOT NULL,
  SUPPLIER_ID       NUMBER(38)                    NOT NULL,
  DAT_VALID_FROM    DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  DAT_REC_END_NEW   DATE                          NOT NULL,
  DAT_REC_END_NEW2  DATE                          NULL,
  NOT_VALID_END_FG  NUMBER(38)                    NOT NULL,
  LOAD_TS           TIMESTAMP_NTZ(6)              NULL
);