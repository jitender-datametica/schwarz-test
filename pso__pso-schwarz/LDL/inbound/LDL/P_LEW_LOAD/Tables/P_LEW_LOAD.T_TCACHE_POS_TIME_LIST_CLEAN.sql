CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_POS_TIME_LIST_CLEAN
(
  CONTEXT_LOAD_ID   NUMBER(38)                    NOT NULL,
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  LOC_SID_STORE     NUMBER(38)                    NOT NULL,
  LOC_SID_WH        NUMBER(38)                    NOT NULL,
  DAT_FORMDATE      DATE                          NULL,
  CONTEXT_COUNTRY   VARCHAR(20) COLLATE 'en-ci'   NULL,
  ORIG_WH_NR        NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR     NUMBER(10,0)                  NOT NULL,
  POS_TERMINAL_ID   NUMBER(38)                    NOT NULL,
  CHECKER_ID        NUMBER(38)                    NULL,
  CHECKER_STATE     NUMBER(38)                    NULL,
  AUDIT_NR          NUMBER(38)                    NULL,
  TI_CODE           NUMBER(38)                    NULL,
  TI_COUNT          NUMBER(18,4)                  NULL,
  DC_SERVER_ID      NUMBER(38)                    NOT NULL,
  TIMESTAMP_RUNNING TIMESTAMP_NTZ(0)              NULL,
  DWH_LOAD_ID       NUMBER(38)                    NOT NULL,
  DWH_CAL_DT        DATE                          NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NOT NULL
);