CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INV_STORE_ITEM_CORR3
(
  CLIENT_ID                       NUMBER(38)                    NOT NULL,
  ITEM_ID                         NUMBER(38)                    NOT NULL,
  POS_NR                          NUMBER(38)                    NOT NULL,
  STORE_ID                        NUMBER(38)                    NOT NULL,
  WH_ID                           NUMBER(38)                    NOT NULL,
  INV_ID                          NUMBER(38)                    NOT NULL,
  DAT_DAYEND                      DATE                          NULL,
  ORDER_AREA_CD                   VARCHAR(5) COLLATE 'en-ci'    NULL,
  WEIGHT_FG                       NUMBER(38)                    NULL,
  PRICE_RETAIL_INV_ITEM_CORR      NUMBER(18,4)                  NULL,
  PRICE_RTL_NET_INV_ITEM_CORR     NUMBER(19,5)                  NULL,
  PRICE_RETAIL_NEW_INV_ITEM_CORR  NUMBER(18,4)                  NULL,
  PRC_RTL_NEW_NET_INV_ITEM_CORR   NUMBER(19,5)                  NULL,
  QTY_CASE_INV_ITEM_CORR          NUMBER(18,4)                  NULL,
  QTY_CASE_NEW_INV_ITEM_CORR      NUMBER(18,4)                  NULL,
  QTY_PIECE_INV_ITEM_CORR         NUMBER(18,4)                  NULL,
  QTY_PIECE_NEW_INV_ITEM_CORR     NUMBER(18,4)                  NULL,
  CASE_SIZE_DEC                   NUMBER(9,4)                   NULL,
  LOAD_ID                         NUMBER(38)                    NOT NULL
);