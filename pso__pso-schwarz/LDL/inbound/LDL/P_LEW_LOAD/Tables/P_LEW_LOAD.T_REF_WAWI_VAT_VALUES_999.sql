CREATE TRANSIENT TABLE P_LEW_LOAD.T_REF_WAWI_VAT_VALUES_999
(
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  VAT_ID              NUMBER(38)                    NOT NULL,
  COUNTRY_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM      DATE                          NOT NULL,
  DAT_VALID_UNTIL     DATE                          NOT NULL,
  DAT_REC_START       DATE                          NOT NULL,
  DAT_REC_END         DATE                          NOT NULL,
  VAT_CAT_ID          NUMBER(38)                    NULL,
  PCT_VAT             NUMBER(4,2)                   NOT NULL,
  VAT_DESC            VARCHAR(60) COLLATE 'en-ci'   NULL,
  FIN_ACCOUNT_NO      NUMBER(38)                    NULL,
  FIN_ACCOUNT_REMARKS NUMBER(38)                    NULL,
  SUPPL_FIN_CD_NAT    VARCHAR(5) COLLATE 'en-ci'    NULL,
  SUPPL_FIN_CD_EU     VARCHAR(5) COLLATE 'en-ci'    NULL,
  SUPPL_FIN_CD_NON_EU VARCHAR(5) COLLATE 'en-ci'    NULL,
  DAT_DAYEND          DATE                          NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);