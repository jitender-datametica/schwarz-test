CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_POS_CLEAN_VAT_AVG_2_CACHE_POS_STORE_VAT_AVG_2
(
  RECORD_ID                     VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID                     NUMBER(38)                    NULL,
  LOC_SID_STORE                 NUMBER(38)                    NULL,
  DWH_CAL_DT                    DATE                          NULL,
  LOC_SID_WH                    NUMBER(38)                    NULL,
  SALES_VAL                     NUMBER(18,5)                  NULL,
  SALES_NET_VAL                 NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_STORE             NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_STORE_PRVS_SHADOW NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_WH                NUMBER(18,5)                  NULL,
  DWH_LOAD_ID                   NUMBER(38)                    NULL,
  DWH_CREATED                   TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED                   TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  ERROR_FG                      NUMBER(38)                    NULL,
  ERROR_DESCR                   VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                      VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO                   NUMBER(38)                    NULL
);