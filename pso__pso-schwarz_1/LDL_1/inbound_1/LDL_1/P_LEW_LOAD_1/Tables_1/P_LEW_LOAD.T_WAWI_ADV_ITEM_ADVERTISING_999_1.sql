CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ADV_ITEM_ADVERTISING_999_1
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  WH_LOC_SID            NUMBER(38)                    NOT NULL,
  ITEM_SID              NUMBER(38)                    NOT NULL,
  DAT_ADV               DATE                          NOT NULL,
  DAT_DAYEND            DATE                          NULL,
  WEEK_ADV              VARCHAR(15) COLLATE 'en-ci'   NOT NULL,
  DAT_NOTIFICATION1     DATE                          NOT NULL,
  DAT_NOTIFICATION2     DATE                          NULL,
  DAT_NOTIFICATIONX     DATE                          NULL,
  REPEAT_FG             NUMBER(38)                    NULL,
  PRICE_RETAIL_ADV      NUMBER(18,4)                  NULL,
  PRICE_RETAIL_NET_ADV  NUMBER(19,5)                  NULL,
  CASE_SIZE_DEC         NUMBER(9,4)                   NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);