CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUPPCOND_HQ_T_1
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  SUP_SID               NUMBER(38)                    NOT NULL,
  DAT_VALID_FROM        DATE                          NULL,
  DAT_VALID_UNTIL       DATE                          NULL,
  PAYMENTTYPE_CD        NUMBER(38)                    NULL,
  EXTRA_SUPPLIER_ID     VARCHAR(7) COLLATE 'en-ci'    NULL,
  DAT_INV_END_FG        NUMBER(38)                    NULL,
  DAT_VALID_FROM_COND   DATE                          NULL,
  POS_NR                NUMBER(38)                    NULL,
  STD_FG                NUMBER(38)                    NULL,
  PAYMENT_TERM_ENTRY_FG NUMBER(38)                    NULL,
  DAYS_CD               NUMBER(38)                    NULL,
  START_TYPE_CD         NUMBER(38)                    NULL,
  START_TYPE_DESC       VARCHAR(25) COLLATE 'en-ci'   NULL,
  DAYS_AFTER_CD         NUMBER(38)                    NULL,
  VAL_DISCOUNT          NUMBER(18,4)                  NULL,
  VAL_REBATE            NUMBER(18,4)                  NULL,
  LANGUAGE_ID           NUMBER(38)                    NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);