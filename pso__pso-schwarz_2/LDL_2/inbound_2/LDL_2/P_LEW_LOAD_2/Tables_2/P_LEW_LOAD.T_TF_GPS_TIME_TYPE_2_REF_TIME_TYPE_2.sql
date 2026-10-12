CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_GPS_TIME_TYPE_2_REF_TIME_TYPE_2
(
  CLIENT_ID                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NOT NULL,
  GPS_TIME_TYPE_COUNTRY_ISO_CD  VARCHAR(9)                    NOT NULL,
  GPS_TIME_TYPE_WH_ID           NUMBER(38,0)                  NOT NULL,
  GPS_TIME_TYPE_MISSINGTYPE_ID  NUMBER(38,0)                  NOT NULL,
  WH_ID                         NUMBER(10,0)                  NOT NULL,
  MISSINGTYPE_ID                NUMBER(10,0)                  NOT NULL,
  SRC_WH_ID                     NUMBER(38)                    NULL,
  SRC_TIME_TYPE_ID              NUMBER(38)                    NULL,
  SRC_TIME_TYPE_CD              VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_SHORT_DESCR         VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIME_TYPE_DESCR               VARCHAR(100) COLLATE 'en-ci'  NULL,
  PRESENCE_FG                   NUMBER(38)                    NULL,
  PERFORMANCE_RELEVANT_FG       NUMBER(38)                    NULL,
  SOURCE_SYSTEM                 VARCHAR(20) COLLATE 'en-ci'   NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NOT NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     VARCHAR(300)                  NOT NULL,
  FILENAME                      VARCHAR(1000)                 NOT NULL
);