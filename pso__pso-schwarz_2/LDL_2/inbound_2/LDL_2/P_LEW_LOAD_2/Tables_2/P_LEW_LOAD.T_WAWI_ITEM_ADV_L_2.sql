CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_ADV_L_2
(
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID                 VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_ITEM_NR          NUMBER(10,0)                  NOT NULL,
  CASE_SIZE             VARCHAR(5) COLLATE 'en-ci'    NOT NULL,
  CASE_SIZE_DEC         NUMBER(9,4)                   NULL,
  WEEK_ADV              VARCHAR(15) COLLATE 'en-ci'   NOT NULL,
  DAT_ADV               DATE                          NOT NULL,
  REPEAT_FG             NUMBER(38)                    NULL,
  PRICE_RETAIL_ADV      NUMBER(18,4)                  NULL,
  DAT_NOTIFICATION1     DATE                          NOT NULL,
  DAT_NOTIFICATION2     DATE                          NULL,
  DAT_NOTIFICATIONX     DATE                          NULL,
  PRICE_RETAIL_ADV_NET  NUMBER(18,4)                  NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
)
;
