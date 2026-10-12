CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPPCOND_HQ_C_TMP_2
(
  ERR_RELEASE           NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER          VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE              DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                NUMBER(38)                    NULL,
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ              VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_SUPPLIER_NR      VARCHAR(7) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM        DATE                          NOT NULL,
  DAT_VALID_UNTIL       DATE                          NULL,
  PAYMENTTYPE_CD        NUMBER(38)                    NULL,
  EXTRA_SUPPLIER_ID     VARCHAR(7) COLLATE 'en-ci'    NULL,
  DAT_INV_END_FG        NUMBER(38)                    NULL,
  DAT_VALID_FROM_COND   DATE                          NOT NULL,
  POS_NR                NUMBER(38)                    NOT NULL,
  STD_FG                NUMBER(38)                    NULL,
  PAYMENT_TERM_ENTRY_FG NUMBER(38)                    NULL,
  DAYS_CD               NUMBER(38)                    NULL,
  START_TYPE_CD         NUMBER(38)                    NULL,
  DAYS_AFTER_CD         NUMBER(38)                    NULL,
  VAL_DISCOUNT          NUMBER(18,4)                  NULL,
  VAL_REBATE            NUMBER(18,4)                  NULL,
  START_TYPE_DESC       VARCHAR(25) COLLATE 'en-ci'   NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NULL
)
;