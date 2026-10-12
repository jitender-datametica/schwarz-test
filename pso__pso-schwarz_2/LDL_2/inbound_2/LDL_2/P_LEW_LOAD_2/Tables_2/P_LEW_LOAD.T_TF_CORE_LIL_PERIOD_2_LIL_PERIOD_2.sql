CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CORE_LIL_PERIOD_2_LIL_PERIOD_2
(
  CLIENT_ID                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NOT NULL,
  CORE_LIL_PERIOD_SRC_PERIOD_CD VARCHAR(250)                  NOT NULL,
  SRC_PERIOD_CD                 VARCHAR(20)                   NOT NULL,
  PERIOD_NAME                   VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  PERIOD_TYPE_ID                NUMBER(38)                    NOT NULL,
  PERIOD_TYPE_NAME              VARCHAR(100) COLLATE 'en-ci'  NULL,
  PERIOD_YEAR                   NUMBER(38)                    NOT NULL,
  SRC_PERIOD_CD_PY              VARCHAR(40)                   NOT NULL,
  SRC_PERIOD_CD_PQ              VARCHAR(40)                   NOT NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NOT NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     VARCHAR(300)                  NOT NULL,
  FILENAME                      VARCHAR(1000)                 NOT NULL
);