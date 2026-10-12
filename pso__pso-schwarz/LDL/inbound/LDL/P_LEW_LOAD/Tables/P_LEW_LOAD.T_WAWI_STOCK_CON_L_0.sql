CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_STOCK_CON_L_0
(
  COUNTRY_ISO_CD    VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID             VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ITM_CONSGR_ID     NUMBER(38)                    NOT NULL,
  ITM_CONSGR_DESC   VARCHAR(35) COLLATE 'en-ci'   NULL,
  DAT_MODIFICATION  DATE                          NULL,
  ORIG_ITEM_NR      NUMBER(10,0)                  NOT NULL,
  ITEM_DESC         VARCHAR(35) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_ID   NUMBER(38)                    NULL,
  PRICE_RETAIL_CONS NUMBER(18,4)                  NULL,
  DAT_DAYEND        DATE                          NULL,
  FILE_NAME         VARCHAR(100) COLLATE 'en-ci'  NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL,
  DC_SERVER_ID      NUMBER(38)                    NOT NULL
);