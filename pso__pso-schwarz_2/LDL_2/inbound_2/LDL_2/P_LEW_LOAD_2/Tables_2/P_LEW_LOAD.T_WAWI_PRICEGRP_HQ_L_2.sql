CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PRICEGRP_HQ_L_2
(
  COUNTRY_ISO_CD  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID           NUMBER(38)                    NOT NULL,
  PRICEGROUP_ID   NUMBER(8,0)                   NOT NULL,
  PRICEGROUP_DESC VARCHAR(30) COLLATE 'en-ci'   NOT NULL,
  PRIORITY        NUMBER(8,0)                   NOT NULL,
  ORIG_STORE_NR   FLOAT                         NOT NULL,
  DAT_VALID_FROM  DATE                          NOT NULL,
  DAT_VALID_UNTIL DATE                          NOT NULL,
  DAT_DAYEND      DATE                          NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL,
  CLIENT_ID       NUMBER(38)                    NULL
);