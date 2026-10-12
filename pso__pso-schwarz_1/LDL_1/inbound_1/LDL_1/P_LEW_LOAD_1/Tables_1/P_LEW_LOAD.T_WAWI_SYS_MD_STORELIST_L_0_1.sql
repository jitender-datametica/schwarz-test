CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SYS_MD_STORELIST_L_0_1
(
  COUNTRY_ISO_CD  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID           NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR   NUMBER(38)                    NOT NULL,
  DAT_OPEN        DATE                          NOT NULL,
  DAT_DAYEND      DATE                          NOT NULL,
  TIMESTAMP_FN    TIMESTAMP_NTZ(0)              NOT NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL,
  DC_SERVER_ID    NUMBER(38)                    NOT NULL
);