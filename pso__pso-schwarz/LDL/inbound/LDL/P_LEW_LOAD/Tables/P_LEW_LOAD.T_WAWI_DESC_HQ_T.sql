CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_DESC_HQ_T
(
  CLIENT_ID       NUMBER(38)                    NOT NULL,
  DESCRIPTION_ID  NUMBER(38)                    NOT NULL,
  CODE            VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  DESCRIPTION     VARCHAR(150) COLLATE 'en-ci'  NOT NULL,
  BUYER_LINK      NUMBER(38)                    NULL,
  READ_ONLY       NUMBER(38)                    NOT NULL,
  DESC_TYPE       VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  LANGUAGE_ID     NUMBER(38)                    NOT NULL,
  DAT_DAYEND      DATE                          NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL
);