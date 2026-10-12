CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PERIOD_L_2
(
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NULL,
  FACTOR_PERIOD         NUMBER(38)                    NULL,
  SHELFLIFE_DESC        VARCHAR(15) COLLATE 'en-ci'   NULL,
  SHELFLIFE_SHORT_DESC  VARCHAR(20) COLLATE 'en-ci'   NULL,
  SHELFLIFE_ID          VARCHAR(5) COLLATE 'en-ci'    NOT NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);