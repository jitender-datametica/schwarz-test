CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PTM_PLANTIMEDAY_2_WORKINGTIME_PLAN_STORE_DAY_2
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  PTM_PLANTIMEDAY_BIC_ZMLILA  VARCHAR(250) COLLATE 'en-ci'  NOT NULL,
  PTM_PLANTIMEDAY_STORENO     NUMBER(19,5)                  NOT NULL,
  PTM_PLANTIMEDAY_PLAN_DATE   DATE                          NOT NULL,
  ORIG_STORE_NR               NUMBER(10,0)                  NOT NULL,
  CAL_DT                      DATE                          NULL,
  TURNOVER_NET_VAL            NUMBER(18,5)                  NULL,
  TURNOVER_PER_HOUR_NET_VAL   NUMBER(18,5)                  NULL,
  HOURS_TOTAL_CNT             NUMBER(18,5)                  NULL,
  HOURS_WORKING_CNT           NUMBER(18,5)                  NULL,
  HOURS_INVENTORY_CNT         NUMBER(18,5)                  NULL,
  HOURS_TRAINING_CNT          NUMBER(18,5)                  NULL,
  HOURS_MISC_CNT              NUMBER(18,5)                  NULL,
  PLAN_UPDATE_TMSP            TIMESTAMP_NTZ(6)              NULL,
  SOURCE_SYSTEM               VARCHAR(20) COLLATE 'en-ci'   NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);