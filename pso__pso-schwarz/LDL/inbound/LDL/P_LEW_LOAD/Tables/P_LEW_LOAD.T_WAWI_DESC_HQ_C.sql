CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_DESC_HQ_C
(
  ERR_ID          NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE     NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER    VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE        DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD          NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CODE            VARCHAR(25) COLLATE 'en-ci'   NOT NULL,
  DESCRIPTION     VARCHAR(80) COLLATE 'en-ci'   NULL,
  BUYER_LINK      NUMBER(38)                    NULL,
  DESCRIPTION_ID  NUMBER(38)                    NOT NULL,
  READ_ONLY       NUMBER(38)                    NOT NULL,
  DESC_TYPE       VARCHAR(25) COLLATE 'en-ci'   NOT NULL,
  DAT_DAYEND      DATE                          NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL
)
;