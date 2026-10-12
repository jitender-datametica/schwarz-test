CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_EXDUTY_HQ_C
(
  ERR_ID          NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE     NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER    VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE        DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD          NUMBER(38)                    NOT NULL,
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
  LOAD_ID         NUMBER(38)                    NULL
)
;