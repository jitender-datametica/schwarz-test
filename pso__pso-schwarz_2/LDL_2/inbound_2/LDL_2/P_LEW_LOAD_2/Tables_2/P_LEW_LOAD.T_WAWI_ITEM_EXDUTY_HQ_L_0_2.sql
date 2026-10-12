CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_EXDUTY_HQ_L_0_2
(
  COUNTRY_ISO_CD  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM  DATE                          NOT NULL,
  DAT_VALID_UNTIL DATE                          NOT NULL,
  ITEM_NR_LONG    VARCHAR(18) COLLATE 'en-ci'   NOT NULL,
  ORIG_ITEM_NR    NUMBER(10,0)                  NOT NULL,
  CASE_SIZE       NUMBER(38)                    NOT NULL,
  MAIN_EXDUTY     NUMBER(38)                    NOT NULL,
  SUB_EXDUTY      NUMBER(38)                    NOT NULL,
  PCT_EXC_DUTY    NUMBER(5,3)                   NULL,
  DAT_DAYEND      DATE                          NULL,
  LOAD_ID         NUMBER(38)                    NULL,
  DC_SERVER_ID    NUMBER(38)                    NOT NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  EXTRACTION_TS   TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM   VARCHAR(20) COLLATE 'en-ci'   NULL
);