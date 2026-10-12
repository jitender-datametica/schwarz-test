CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_PTM_PLANTIMEDAY_1
(
  CLIENT_ID                 NUMBER(38)                    NOT NULL,
  BIC_ZMLILA                VARCHAR(40)                   NOT NULL,
  LOC_SID_STORE             NUMBER(38)                    NOT NULL,
  CAL_DT                    DATE                          NOT NULL,
  TURNOVER_NET_VAL          NUMBER(18,5)                  NULL,
  TURNOVER_PER_HOUR_NET_VAL NUMBER(18,5)                  NULL,
  HOURS_TOTAL_CNT           NUMBER(18,5)                  NULL,
  HOURS_WORKING_CNT         NUMBER(18,5)                  NULL,
  HOURS_INVENTORY_CNT       NUMBER(18,5)                  NULL,
  HOURS_TRAINING_CNT        NUMBER(18,5)                  NULL,
  HOURS_MISC_CNT            NUMBER(18,5)                  NULL,
  PLAN_UPDATE_TMSP          TIMESTAMP_NTZ(6)              NULL,
  SOURCE_SYSTEM             VARCHAR(20) COLLATE 'en-ci'   NULL,
  FILE_RECORD_ID            NUMBER(38)                    NULL,
  DWH_LOAD_ID               NUMBER(38)                    NOT NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NOT NULL
);