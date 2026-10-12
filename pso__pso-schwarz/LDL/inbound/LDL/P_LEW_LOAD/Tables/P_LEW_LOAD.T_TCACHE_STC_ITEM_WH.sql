CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_STC_ITEM_WH
(
  CONTEXT_LOAD_ID     NUMBER(38)                    NOT NULL,
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  CONTEXT_COUNTRY     VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  LOC_SID_WH          NUMBER(38)                    NOT NULL,
  SRC_ORIG_WH_NR      NUMBER(38)                    NOT NULL,
  ITEM_NR_LONG        VARCHAR(14) COLLATE 'en-ci'   NOT NULL,
  ITEM_SID            NUMBER(38)                    NOT NULL,
  SRC_ORIG_ITEM_NR    NUMBER(10,0)                  NOT NULL,
  SRC_CASE_SIZE       NUMBER(38)                    NOT NULL,
  QTY_PIECE_STC_WH    NUMBER(18,4)                  NOT NULL,
  PRICE_RETAIL_STC_WH NUMBER(18,4)                  NULL,
  PRICE_RETAIL_STC_WH_NET NUMBER(18,4)                  NULL,
  FROM_ERRORFILE_FG   NUMBER(38)                    NULL,
  DAT_DAYEND          DATE                          NULL,
  DWH_LOAD_ID         NUMBER(38)                    NOT NULL,
  DWH_CAL_DT          DATE                          NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NOT NULL
);