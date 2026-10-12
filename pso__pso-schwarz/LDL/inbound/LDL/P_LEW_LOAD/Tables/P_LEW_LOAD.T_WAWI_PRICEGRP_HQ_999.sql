CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PRICEGRP_HQ_999
(
  CLIENT_ID       NUMBER(38)                    NOT NULL,
  PRICEGROUP_ID   NUMBER(8,0)                   NOT NULL,
  WH_LOC_SID      NUMBER(38)                    NOT NULL,
  ST_LOC_SID      NUMBER(38)                    NOT NULL,
  DAT_VALID_FROM  DATE                          NOT NULL,
  DAT_VALID_UNTIL DATE                          NOT NULL,
  PRICEGROUP_DESC VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  PRIORITY        NUMBER(8,0)                   NOT NULL,
  LANGUAGE_ID     NUMBER(38)                    NOT NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL
);