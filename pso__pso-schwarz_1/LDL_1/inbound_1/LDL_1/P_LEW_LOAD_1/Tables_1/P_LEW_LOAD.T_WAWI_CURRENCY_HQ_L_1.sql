CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURRENCY_HQ_L_1
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_NR             NUMBER(3,0)                   NOT NULL,
  CURRENCY_ISO_CD         VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_DESC           VARCHAR(28) COLLATE 'en-ci'   NOT NULL,
  DAT_VALID_FROM          DATE                          NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(6,0)                   NULL,
  CURRENCY_TOLERANCE      NUMBER(18,4)                  NULL,
  CURRENCY_SIGN1          VARCHAR(3) COLLATE 'en-ci'    NULL,
  CURRENCY_SIGN2          VARCHAR(3) COLLATE 'en-ci'    NULL,
  DAT_DAYEND              DATE                          NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
);