CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INV_STC_STORE_ITEM
(
  STORE_ID              NUMBER(38)                    NOT NULL,
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  ITEM_ID               NUMBER(38)                    NOT NULL,
  DAT_FORMDATE          DATE                          NOT NULL,
  QTY_INV_STC_CALC      NUMBER(18,4)                  NULL,
  QTY_INV_STC_CNT       NUMBER(18,4)                  NULL,
  DIFF_INV_STC_CALC_CNT NUMBER(18,4)                  NULL,
  STATUS_INV_STC        NUMBER(38)                    NULL,
  PRICE_RETAIL          NUMBER(18,4)                  NULL,
  PRICE_RETAIL_NET      NUMBER(19,5)                  NULL,
  PRICE_DIFF            NUMBER(18,4)                  NULL,
  PRICE_NET_DIFF        NUMBER(19,5)                  NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);