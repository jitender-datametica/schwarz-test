CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INDICATOR_DAY_C_1
(
  ERR_ID            NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE       NUMBER(38)                    NULL,
  RELEASE_USER      VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE          DATE                          NOT NULL,
  ERR_CD            NUMBER(38)                    NOT NULL,
  INDICATOR_ID      NUMBER(38)                    NOT NULL,
  INDICATOR_TYPE_ID NUMBER(38)                    NOT NULL,
  ORG_TYPE_ID       NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD    VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  ORG_UNIT_NR       NUMBER(38)                    NULL,
  CY                NUMBER(38)                    NOT NULL,
  DAT_FORMDATE      DATE                          NOT NULL,
  CURRENCY_ISO_CD   VARCHAR(3) COLLATE 'en-ci'    NULL,
  VAL_INDICATOR     NUMBER(18,4)                  NULL,
  FILE_NAME         VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND        DATE                          NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);