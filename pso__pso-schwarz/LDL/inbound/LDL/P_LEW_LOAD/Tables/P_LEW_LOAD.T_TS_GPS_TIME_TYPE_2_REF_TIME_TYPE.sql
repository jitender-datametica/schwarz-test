CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_GPS_TIME_TYPE_2_REF_TIME_TYPE
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  TIME_TYPE_SID           NUMBER(38)                    NULL,
  SRC_WH_ID               NUMBER(38)                    NULL,
  SRC_TIME_TYPE_ID        NUMBER(38)                    NULL,
  SRC_TIME_TYPE_CD        VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_SHORT_DESCR   VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_DESCR         VARCHAR(100) COLLATE 'en-ci'  NULL,
  PRESENCE_FG             NUMBER(38)                    NULL,
  PERFORMANCE_RELEVANT_FG NUMBER(38)                    NULL,
  SOURCE_SYSTEM           VARCHAR(20) COLLATE 'en-ci'   NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);