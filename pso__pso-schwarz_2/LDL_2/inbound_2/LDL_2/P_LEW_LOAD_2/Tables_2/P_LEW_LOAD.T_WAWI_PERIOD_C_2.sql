CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PERIOD_C_2
(
  ERR_ID                NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE           NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER          VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE              DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NULL,
  FACTOR_PERIOD         NUMBER(38)                    NULL,
  SHELFLIFE_DESC        VARCHAR(15) COLLATE 'en-ci'   NULL,
  SHELFLIFE_SHORT_DESC  VARCHAR(20) COLLATE 'en-ci'   NULL,
  SHELFLIFE_ID          VARCHAR(5) COLLATE 'en-ci'    NOT NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
)
;