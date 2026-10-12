CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CORE_LIL_PERIOD_PER_REGION_2_LIL_PERIOD_PER_REGION_1
(
  RECORD_ID       VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  PERIOD_SID      NUMBER(38)                    NULL,
  REGION_SID      NUMBER(38)                    NULL,
  START_DT        DATE                          NULL,
  END_DT          DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);