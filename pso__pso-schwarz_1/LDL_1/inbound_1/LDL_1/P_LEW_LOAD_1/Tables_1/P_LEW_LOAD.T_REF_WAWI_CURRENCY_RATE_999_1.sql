CREATE TRANSIENT TABLE P_LEW_LOAD.T_REF_WAWI_CURRENCY_RATE_999_1
(
  CLIENT_ID               NUMBER(38)                    NOT NULL,
  CURRENCY_NR             NUMBER(38)                    NOT NULL,
  CURRENCY_ISO_CD         VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM          DATE                          NOT NULL,
  DAT_VALID_UNTIL         DATE                          NOT NULL,
  UNIT_CURRENCY_EXCHANGE  NUMBER(9,2)                   NOT NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,4)                  NOT NULL,
  DAT_DAYEND              DATE                          NOT NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
);