CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CORE_LIL_PERIOD_PER_REGION_2_LIL_PERIOD_PER_REGION_1
(
  CLIENT_ID                                 NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                              VARCHAR(40)                   NOT NULL,
  CORE_LIL_PERIOD_PER_REGION_SRC_REGION_CD  VARCHAR(250)                  NOT NULL,
  CORE_LIL_PERIOD_PER_REGION_SRC_PERIOD_CD  VARCHAR(250)                  NOT NULL,
  SRC_PERIOD_CD                             VARCHAR(40)                   NOT NULL,
  SRC_REGION_CD                             VARCHAR(40)                   NOT NULL,
  START_DT                                  DATE                          NULL,
  END_DT                                    DATE                          NULL,
  EXTRACTION_DT                             DATE                          NULL,
  DWH_MAPPING_DT                            DATE                          NOT NULL,
  TF_ERROR_FG                               NUMBER(1,0)                   NULL,
  RECORD_ID                                 VARCHAR(300)                  NOT NULL,
  FILENAME                                  VARCHAR(1000)                 NOT NULL
);