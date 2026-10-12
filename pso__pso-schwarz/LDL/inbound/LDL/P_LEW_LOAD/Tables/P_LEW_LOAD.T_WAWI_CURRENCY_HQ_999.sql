CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURRENCY_HQ_999
(
  CLIENT_ID               NUMBER(38)                    NOT NULL,
  CURRENCY_NR             NUMBER(38)                    NULL,
  CURRENCY_ISO_CD         VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_DESC           VARCHAR(50) COLLATE 'en-ci'   NULL,
  DAT_VALID_FROM          DATE                          NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,4)                  NULL,
  CURRENCY_TOLERANCE      FLOAT                         NULL,
  CURRENCY_SIGN1          VARCHAR(5) COLLATE 'en-ci'    NULL,
  CURRENCY_SIGN2          VARCHAR(5) COLLATE 'en-ci'    NULL,
  DAT_DAYEND              DATE                          NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
);