CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_TXJ_520_1
(
  CLIENT_ID       NUMBER(38)                    NOT NULL,
  LOC_SID         NUMBER(38)                    NOT NULL,
  ITEM_SID        NUMBER(38)                    NULL,
  ITEM_NR         VARCHAR(20) COLLATE 'en-ci'   NULL,
  RECORD_CD       VARCHAR(12) COLLATE 'en-ci'   NOT NULL,
  VERSION                         VARCHAR(3)                    NULL,
  CONTEXT_COUNTRY VARCHAR(20) COLLATE 'en-ci'   NULL,
  SNAPSHOT_TMSP   TIMESTAMP_NTZ(6)              NULL,
  SALES_QTY       NUMBER(18,5)                  NULL,
  SALES_VAL       NUMBER(18,5)                  NULL,
  RETURNS_QTY     NUMBER(18,5)                  NULL,
  RETURNS_VAL     NUMBER(18,5)                  NULL,
  VOIDS_QTY       NUMBER(18,5)                  NULL,
  VOIDS_VAL       NUMBER(18,5)                  NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CAL_DT      DATE                          NOT NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  CONTEXT_LOAD_ID NUMBER(38)                    NOT NULL
);