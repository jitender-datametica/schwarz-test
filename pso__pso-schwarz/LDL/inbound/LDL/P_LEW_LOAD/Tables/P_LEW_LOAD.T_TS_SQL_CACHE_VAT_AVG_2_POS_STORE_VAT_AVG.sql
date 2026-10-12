CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_CACHE_VAT_AVG_2_POS_STORE_VAT_AVG
(
  RECORD_ID       VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  LOC_SID         NUMBER(38)                    NULL,
  DWH_CAL_DT      DATE                          NULL,
  AVG_PCT_VAT     NUMBER(18,5)                  NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);