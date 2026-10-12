CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURR_RATE_HQ_C_1
(
  ERR_ID                  NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE             NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER            VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                  NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_NR             NUMBER(3,0)                   NOT NULL,
  DAT_VALID_FROM          DATE                          NOT NULL,
  UNIT_CURRENCY_EXCHANGE  NUMBER(6,2)                   NOT NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,4)                  NULL,
  FILE_NAME               VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN            TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND              DATE                          NOT NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
)
;