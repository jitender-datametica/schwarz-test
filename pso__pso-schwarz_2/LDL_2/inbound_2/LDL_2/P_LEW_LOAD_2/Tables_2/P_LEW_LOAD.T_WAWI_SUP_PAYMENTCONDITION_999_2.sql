CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_PAYMENTCONDITION_999_2
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  SUP_SID               NUMBER(38)                    NOT NULL,
  DAT_REC_START         DATE                          NOT NULL,
  DAT_REC_END           DATE                          NOT NULL,
  DAT_VALID_FROM        DATE                          NOT NULL,
  DAT_VALID_FROM_COND   DATE                          NOT NULL,
  DAT_VALID_UNTIL       DATE                          NULL,
  DAT_INV_END_FG        NUMBER(38)                    NULL,
  STD_FG                NUMBER(38)                    NULL,
  DAYS_CD               NUMBER(38)                    NULL,
  DAYS_AFTER_CD         NUMBER(38)                    NULL,
  POS_NR                NUMBER(38)                    NOT NULL,
  START_TYPE_CD         NUMBER(38)                    NULL,
  PAYMENTTYPE_CD        NUMBER(38)                    NULL,
  PAYMENT_TERM_ENTRY_FG NUMBER(38)                    NULL,
  EXTRA_SUP_SID         VARCHAR(7) COLLATE 'en-ci'    NULL,
  VAL_DISCOUNT          NUMBER(18,4)                  NULL,
  VAL_REBATE            NUMBER(18,4)                  NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);