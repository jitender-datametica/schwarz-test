CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_PRICE_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  ITEM_ID           NUMBER(38)                    NOT NULL,
  PRICEGROUP_ID     NUMBER(8,0)                   NOT NULL,
  DAT_VALID_FROM    DATE                          NOT NULL,
  DAT_VALID_UNTIL   DATE                          NOT NULL,
  VAT_ID            NUMBER(38)                    NOT NULL,
  TARE_CD           NUMBER(38)                    NULL,
  PRICE_RETAIL      NUMBER(18,4)                  NULL,
  PRICE_RETAIL_NET  NUMBER(19,5)                  NULL,
  VAL_REFUND        NUMBER(18,4)                  NULL,
  VAL_NET_REFUND    NUMBER(19,5)                  NULL,
  VAL_BEVERAGE_TAX  NUMBER(18,4)                  NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);