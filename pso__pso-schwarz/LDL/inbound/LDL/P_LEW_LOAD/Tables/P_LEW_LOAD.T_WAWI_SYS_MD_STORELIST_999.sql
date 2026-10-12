CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_SYS_MD_STORELIST_999
(
  CLIENT_ID     NUMBER(38)                    NOT NULL,
  WH_LOC_SID    NUMBER(38)                    NOT NULL,
  ST_LOC_SID    NUMBER(38)                    NOT NULL,
  DAT_OPEN      DATE                          NOT NULL,
  DAT_DAYEND    DATE                          NOT NULL,
  TIMESTAMP_FN  TIMESTAMP_NTZ(0)              NOT NULL,
  LOAD_ID       NUMBER(38)                    NOT NULL
);