CREATE TRANSIENT TABLE P_LEW_LOAD.T_ORG_STORE_SKEY_NEW
(
  CLIENT_ID     NUMBER(38)                    NOT NULL,
  ST_LOC_SID    NUMBER(38)                    NOT NULL,
  DAT_REC_START DATE                          NOT NULL,
  DAT_REC_END   DATE                          NOT NULL,
  WH_LOC_SID    NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR NUMBER(38)                    NOT NULL,
  LOAD_ID       NUMBER(38)                    NOT NULL
);