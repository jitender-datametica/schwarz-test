CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURRENCY_HQ_C_2
(
  ERR_ID                  NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE             NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER            VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                  NUMBER(38)                    NOT NULL,
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
)
;