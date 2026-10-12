CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_GPS_WORKINGTIMES_1
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  BIC_ZMLILA            VARCHAR(20)                   NULL,
  ORIG_STORE_NR         NUMBER(10,0)                  NOT NULL,
  TIME_RECORD_ID        NUMBER(38)                    NOT NULL,
  TIME_RECORD_CHANGE_DT DATE                          NOT NULL,
  EMPLOYEE_HASH         VARCHAR(100) COLLATE 'en-ci'  NULL,
  WH_ID                 NUMBER(10,0)                  NULL,
  MISSINGTYPE_ID        VARCHAR(40)                   NULL,
  EVENT_TYPE_CD         VARCHAR(3) COLLATE 'en-ci'    NULL,
  EVENT_TMSP            TIMESTAMP_NTZ(6)              NULL,
  EVENT_BOOKING_TYPE_CD VARCHAR(1) COLLATE 'en-ci'    NULL,
  CANCEL_FG             NUMBER(38)                    NOT NULL,
  FILE_RECORD_ID        NUMBER(38)                    NULL,
  DWH_LOAD_ID           NUMBER(38)                    NOT NULL,
  DWH_CAL_DT            DATE                          NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NOT NULL
);