CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_STOREHIST_HQ_L_2
(
  COUNTRY_ISO_CD  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID           NUMBER(3,0)                   NOT NULL,
  ORIG_STORE_NR   NUMBER(4,0)                   NOT NULL,
  DAT_VALID_FROM  DATE                          NOT NULL,
  DAT_VALID_UNTIL DATE                          NOT NULL,
  DAT_DAYEND      DATE                          NULL,
  LOAD_ID         NUMBER(38)                    NULL
);