CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_POS_TIME_LIST_LOAD_2
(
  CONTEXT_LOAD_ID   NUMBER(38)                    NOT NULL,
  CONTEXT_COUNTRY   VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ORIG_WH_NR        NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR     NUMBER(10,0)                  NOT NULL,
  EXTRACTION_DT     DATE                          NOT NULL,
  CHECKER_ID        NUMBER(38)                    NOT NULL,
  CHECKER_STATE     NUMBER(38)                    NOT NULL,
  AUDIT_NR          NUMBER(38)                    NOT NULL,
  DWH_MAPPING_DT    DATE                          NOT NULL,
  POS_TERMINAL_ID   NUMBER(38)                    NOT NULL,
  TIMESTAMP_RUNNING TIMESTAMP_NTZ(0)              NULL,
  TI_CODE           NUMBER(38)                    NOT NULL,
  TI_COUNT          NUMBER(18,4)                  NOT NULL,
  DWH_LOAD_ID       NUMBER(38)                    NOT NULL,
  DC_SERVER_ID      NUMBER(38)                    NOT NULL
);