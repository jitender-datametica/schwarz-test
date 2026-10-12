CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SUP_BANK_999
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  SUP_SID           NUMBER(38)                    NOT NULL,
  BANK_ID           NUMBER(38)                    NULL,
  ACCOUNT_NR        VARCHAR(20) COLLATE 'en-ci'   NULL,
  DAT_REC_END       DATE                          NULL,
  DAT_REC_START     DATE                          NULL,
  IBAN              VARCHAR(35) COLLATE 'en-ci'   NULL,
  CHARGE_KEY_CD     VARCHAR(5) COLLATE 'en-ci'    NULL,
  CHECK_KEY_CD      VARCHAR(5) COLLATE 'en-ci'    NULL,
  ALT_PAYEE         VARCHAR(10) COLLATE 'en-ci'   NULL,
  BLOCK_PAYMENT_FG  NUMBER(38)                    NULL,
  AVIS_FAX          VARCHAR(50) COLLATE 'en-ci'   NULL,
  AVIS_EMAIL        VARCHAR(245) COLLATE 'en-ci'  NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);