CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_TCACHE_GPS_WORKINGTIMES_2_TIME_TRACKING_RECORD_2
(
  RECORD_ID             VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  LOC_SID               NUMBER(38)                    NULL,
  TIME_RECORD_ID        NUMBER(38)                    NULL,
  TIME_RECORD_CHANGE_DT DATE                          NULL,
  EMPLOYEE_HASH         VARCHAR(100) COLLATE 'en-ci'  NULL,
  TIME_TYPE_SID         NUMBER(38)                    NULL,
  EVENT_TYPE_CD         VARCHAR(3) COLLATE 'en-ci'    NULL,
  EVENT_TMSP            TIMESTAMP_NTZ(6)              NULL,
  EVENT_BOOKING_TYPE_CD VARCHAR(1) COLLATE 'en-ci'    NULL,
  CANCEL_FG             NUMBER(38)                    NULL,
  DWH_CAL_DT            DATE                          NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);