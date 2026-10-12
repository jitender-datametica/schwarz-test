CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_TCACHE_GPS_PLANTIMEDAY_2_WORKINGTIME_PLAN_STORE_DAY_2
(
  CLIENT_ID                         NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                      VARCHAR(40)                   NOT NULL,
  TCACHE_GPS_PLANTIMEDAY_BIC_ZMLILA VARCHAR(60)                   NOT NULL,
  TCACHE_GPS_PLANTIMEDAY_STORE      NUMBER(38,0)                  NOT NULL,
  TCACHE_GPS_PLANTIMEDAY_CAL_DT     DATE                          NOT NULL,
  STORE                             NUMBER(10,0)                  NOT NULL,
  CAL_DT                            DATE                          NOT NULL,
  TURNOVER_NET_VAL                  NUMBER(18,5)                  NULL,
  TURNOVER_PER_HOUR_NET_VAL         NUMBER(18,5)                  NULL,
  HOURS_TOTAL_CNT                   NUMBER(18,5)                  NULL,
  HOURS_WORKING_CNT                 NUMBER(18,5)                  NULL,
  HOURS_INVENTORY_CNT               NUMBER(18,5)                  NULL,
  HOURS_TRAINING_CNT                NUMBER(18,5)                  NULL,
  HOURS_MISC_CNT                    NUMBER(18,5)                  NULL,
  PLAN_UPDATE_TMSP                  TIMESTAMP_NTZ(6)              NULL,
  SOURCE_SYSTEM                     VARCHAR(20) COLLATE 'en-ci'   NULL,
  EXTRACTION_DT                     DATE                          NULL,
  DWH_MAPPING_DT                    DATE                          NOT NULL,
  TF_ERROR_FG                       NUMBER(1,0)                   NULL,
  RECORD_ID                         VARCHAR(300)                  NOT NULL,
  FILENAME                          VARCHAR(1000)                 NOT NULL
);