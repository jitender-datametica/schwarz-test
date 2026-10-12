CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_FEDSTATE_US_2_LIL_FEDSTATE_US_1
(
  CLIENT_ID                                   NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                                VARCHAR(40)                   NOT NULL,
  PROCESS_MSTR_LIL_FEDSTATE_US_SRC_REGION_CD  VARCHAR(250)                  NOT NULL,
  PROCESS_MSTR_LIL_FEDSTATE_US_FEDSTATE_CD    VARCHAR(250)                  NOT NULL,
  PROCESS_MSTR_LIL_FEDSTATE_US_VALID_FROM     DATE                          NOT NULL,
  SRC_REGION_CD                               VARCHAR(200)                  NOT NULL,
  FEDSTATE_CD                                 VARCHAR(20)                   NOT NULL,
  VALID_FROM                                  DATE                          NOT NULL,
  VALID_TO                                    DATE                          NOT NULL,
  ACTIVE_FG                                   NUMBER(38)                    NOT NULL,
  EXTRACTION_DT                               DATE                          NULL,
  DWH_MAPPING_DT                              DATE                          NOT NULL,
  TF_ERROR_FG                                 NUMBER(1,0)                   NULL,
  RECORD_ID                                   VARCHAR(300)                  NOT NULL,
  FILENAME                                    VARCHAR(1000)                 NOT NULL
);