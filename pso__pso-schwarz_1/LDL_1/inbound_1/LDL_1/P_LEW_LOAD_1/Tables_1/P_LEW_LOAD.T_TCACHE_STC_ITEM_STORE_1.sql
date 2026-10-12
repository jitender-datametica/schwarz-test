CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_STC_ITEM_STORE_1
(
  CONTEXT_LOAD_ID   NUMBER(38)                    NOT NULL,
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  CONTEXT_COUNTRY   VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  LOC_SID_WH        NUMBER(38)                    NOT NULL,
  SRC_ORIG_WH_NR    NUMBER(38)                    NOT NULL,
  DAT_FORMDATE      DATE                          NULL,
  LOC_SID_STORE     NUMBER(38)                    NOT NULL,
  SRC_ORIG_STORE_NR NUMBER(38)                    NOT NULL,
  ITEM_SID          NUMBER(38)                    NOT NULL,
  SRC_ORIG_ITEM_NR  NUMBER(10,0)                  NOT NULL,
  QTY_STC_CALC      NUMBER(18,4)                  NOT NULL,
  QTY_STC_INV       NUMBER(18,4)                  NULL,
  DIFF_STC_INV_CALC NUMBER(18,4)                  NULL,
  FROM_ERRORFILE_FG NUMBER(38)                    NULL,
  DAT_DAYEND        DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NOT NULL,
  DWH_CAL_DT        DATE                          NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NOT NULL
);