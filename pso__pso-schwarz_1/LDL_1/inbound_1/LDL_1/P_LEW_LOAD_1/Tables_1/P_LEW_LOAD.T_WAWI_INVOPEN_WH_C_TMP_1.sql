CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INVOPEN_WH_C_TMP_1
(
  ERR_RELEASE               NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER              VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                  DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                    NUMBER(38)                    NULL,
  COUNTRY_ISO_CD            VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID                     VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  INV_ID                    NUMBER(38)                    NULL,
  ORIG_STORE_NR             NUMBER(38)                    NULL,
  SFOTYPE_ID                NUMBER(38)                    NULL,
  SFOTYPE_DESC              VARCHAR(40) COLLATE 'en-ci'   NULL,
  DAT_FORMDATE              DATE                          NULL,
  VAL_DEBIT_OPENDOCS        FLOAT                         NULL,
  VAL_CREDIT_OPENDOCS       FLOAT                         NULL,
  ORIG_RECEIPT_NR_OPENDOCS  VARCHAR(20) COLLATE 'en-ci'   NULL,
  DAT_DAYEND                DATE                          NULL,
  LOAD_ID                   NUMBER(38)                    NULL
)
;