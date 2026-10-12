CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INVOPEN_WH_L_1
(
  COUNTRY_ISO_CD            VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID                     VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  INV_ID                    NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR             NUMBER(38)                    NULL,
  SFOTYPE_ID                NUMBER(38)                    NULL,
  SFOTYPE_DESC              VARCHAR(40) COLLATE 'en-ci'   NULL,
  DAT_FORMDATE              DATE                          NOT NULL,
  VAL_DEBIT_OPENDOCS        NUMBER(18,4)                  NULL,
  VAL_DEBIT_OPENDOCS_NET    NUMBER(18,4)                  NULL,
  VAL_CREDIT_OPENDOCS       NUMBER(18,4)                  NULL,
  VAL_CREDIT_OPENDOCS_NET   NUMBER(18,4)                  NULL,
  ORIG_RECEIPT_NR_OPENDOCS  VARCHAR(20) COLLATE 'en-ci'   NULL,
  DAT_DAYEND                DATE                          NULL,
  LOAD_ID                   NUMBER(38)                    NOT NULL
);