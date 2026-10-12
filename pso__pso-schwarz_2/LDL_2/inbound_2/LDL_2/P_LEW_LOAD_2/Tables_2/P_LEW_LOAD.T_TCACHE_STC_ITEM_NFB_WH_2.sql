CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_STC_ITEM_NFB_WH_2
(
  CONTEXT_LOAD_ID   NUMBER(38)                    NOT NULL,
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  CONTEXT_COUNTRY   VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  LOC_SID           NUMBER(38)                    NOT NULL,
  ITEM_SID          NUMBER(38)                    NOT NULL,
  ORIG_WH_NR        NUMBER(38)                    NOT NULL,
  ORIG_ITEM_NR      NUMBER(38)                    NOT NULL,
  CASE_SIZE         NUMBER(38)                    NOT NULL,
  POS_NR            NUMBER(38)                    NOT NULL,
  POS_NR_LINK       NUMBER(38)                    NULL,
  NFB_TYPE_CD       NUMBER(38)                    NOT NULL,
  CASE_QTY          NUMBER(18,5)                  NULL,
  DAT_MODIFICATION  DATE                          NULL,
  DAT_DAYEND        DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NOT NULL,
  DWH_CAL_DT        DATE                          NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NOT NULL
);