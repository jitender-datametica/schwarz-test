CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_TCACHE_GPS_PLANTIMEDAY_2_WORKINGTIME_PLAN_STORE_DAY_2
(
  RECORD_ID                 VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  LOC_SID_STORE             NUMBER(38)                    NULL,
  CAL_DT                    DATE                          NULL,
  TURNOVER_NET_VAL          NUMBER(18,5)                  NULL,
  TURNOVER_PER_HOUR_NET_VAL NUMBER(18,5)                  NULL,
  HOURS_TOTAL_CNT           NUMBER(18,5)                  NULL,
  HOURS_WORKING_CNT         NUMBER(18,5)                  NULL,
  HOURS_INVENTORY_CNT       NUMBER(18,5)                  NULL,
  HOURS_TRAINING_CNT        NUMBER(18,5)                  NULL,
  HOURS_MISC_CNT            NUMBER(18,5)                  NULL,
  PLAN_UPDATE_TMSP          TIMESTAMP_NTZ(6)              NULL,
  SOURCE_SYSTEM             VARCHAR(20) COLLATE 'en-ci'   NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);