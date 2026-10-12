CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_REF_VAT_999_2
(
  CLIENT_ID     NUMBER(38)                    NOT NULL,
  VAT_ID        NUMBER(38)                    NOT NULL,
  DAT_REC_START DATE                          NOT NULL,
  DAT_REC_END   DATE                          NOT NULL,
  VAT_DESC      VARCHAR(60) COLLATE 'en-ci'   NULL,
  PCT_VAT       NUMBER(18,4)                  NULL,
  LANGUAGE_ID   NUMBER(38)                    NOT NULL,
  LOAD_ID       NUMBER(38)                    NULL
);