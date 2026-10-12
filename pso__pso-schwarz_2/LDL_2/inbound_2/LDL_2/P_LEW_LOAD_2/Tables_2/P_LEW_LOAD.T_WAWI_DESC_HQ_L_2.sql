CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_DESC_HQ_L_2
(
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
);