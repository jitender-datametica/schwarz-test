CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_VAT_VALUES_STORE_HQ_C_2
(
  ERR_ID            NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE       NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER      VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE          DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD            NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD    VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ          NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR     NUMBER(38)                    NOT NULL,
  VAT_ID            NUMBER(38)                    NOT NULL,
  STORE_VAT_ID      NUMBER(38)                    NOT NULL,
  COUNTRY_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_MODIFICATION  DATE                          NULL,
  FILE_NAME         VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND        DATE                          NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
)
;