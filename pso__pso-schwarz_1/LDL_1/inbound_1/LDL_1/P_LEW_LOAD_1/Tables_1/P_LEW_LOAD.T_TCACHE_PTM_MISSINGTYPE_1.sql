CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_PTM_MISSINGTYPE_1
(
  CLIENT_ID               NUMBER(38)                    NOT NULL,
  BIC_ZMLILA              VARCHAR(20)                   NULL,
  MISSINGTYPE_ID          NUMBER(38,0)                  NOT NULL,
  SRC_WH_ID               NUMBER(38)                    NULL,
  SRC_TIME_TYPE_ID        NUMBER(38)                    NULL,
  SRC_TIME_TYPE_CD        VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_SHORT_DESCR   VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_DESCR         VARCHAR(100) COLLATE 'en-ci'  NULL,
  PRESENCE_FG             NUMBER(38)                    NULL,
  PERFORMANCE_RELEVANT_FG NUMBER(38)                    NULL,
  SOURCE_SYSTEM           VARCHAR(20) COLLATE 'en-ci'   NULL,
  FILE_RECORD_ID          NUMBER(38)                    NULL,
  DWH_LOAD_ID             NUMBER(38)                    NOT NULL,
  DWH_CAL_DT              DATE                          NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NOT NULL
);