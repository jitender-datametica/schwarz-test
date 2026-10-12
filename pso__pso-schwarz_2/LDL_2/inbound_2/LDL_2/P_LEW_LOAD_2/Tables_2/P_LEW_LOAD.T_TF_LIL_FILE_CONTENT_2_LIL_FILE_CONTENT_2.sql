CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_FILE_CONTENT_2_LIL_FILE_CONTENT_2
(
  CLIENT_ID                                 NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                              VARCHAR(40)                   NOT NULL,
  LIL_FILE_CONTENT_FILE_ID                  NUMBER(10,0)                  NOT NULL,
  LIL_FILE_CONTENT_SRC_REGION_CD            VARCHAR(20)                   NOT NULL,
  LIL_FILE_CONTENT_SRC_PERIOD_CD            VARCHAR(20)                   NOT NULL,
  LIL_FILE_CONTENT_SRC_ASSORT_PARENT_CAT_CD VARCHAR(100)                  NOT NULL,
  FILE_ID                                   NUMBER(38)                    NOT NULL,
  SRC_REGION_CD                             VARCHAR(40)                   NOT NULL,
  SRC_PERIOD_CD                             VARCHAR(40)                   NOT NULL,
  SRC_ASSORT_PARENT_CAT_CD                  VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  EXTRACTION_DT                             DATE                          NULL,
  DWH_MAPPING_DT                            DATE                          NOT NULL,
  TF_ERROR_FG                               NUMBER(1,0)                   NULL,
  RECORD_ID                                 VARCHAR(300)                  NOT NULL,
  FILENAME                                  VARCHAR(1000)                 NOT NULL
);