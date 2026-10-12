CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_VAT_VALUES_HQ_L
(
  COUNTRY_ISO_CD      VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ            NUMBER(38)                    NOT NULL,
  VAT_ID              NUMBER(38)                    NOT NULL,
  COUNTRY_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM      DATE                          NOT NULL,
  VAT_CAT_ID          NUMBER(38)                    NULL,
  DAT_VALID_UNTIL     DATE                          NOT NULL,
  PCT_VAT             NUMBER(4,2)                   NOT NULL,
  VAT_DESC            VARCHAR(60) COLLATE 'en-ci'   NULL,
  FIN_ACCOUNT_NO      NUMBER(38)                    NULL,
  FIN_ACCOUNT_REMARKS NUMBER(38)                    NULL,
  SUPPL_FIN_CD_NAT    VARCHAR(5) COLLATE 'en-ci'    NULL,
  SUPPL_FIN_CD_EU     VARCHAR(5) COLLATE 'en-ci'    NULL,
  SUPPL_FIN_CD_NON_EU VARCHAR(5) COLLATE 'en-ci'    NULL,
  FILE_NAME           VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN        TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND          DATE                          NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);