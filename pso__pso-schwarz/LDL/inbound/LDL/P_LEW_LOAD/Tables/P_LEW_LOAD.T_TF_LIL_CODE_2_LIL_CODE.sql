CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_CODE_2_LIL_CODE
(
  MAIN_CODE           VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  LIL_CODE_MAIN_CODE  VARCHAR(250)                  NOT NULL,
  LIL_CODE_SUB_CODE   VARCHAR(250)                  NOT NULL,
  LIL_CODE_KEY_FIELD  VARCHAR(250)                  NOT NULL,
  SUB_CODE            VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  KEY_FIELD           VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  VAL                 VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NOT NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           VARCHAR(300)                  NOT NULL,
  FILENAME            VARCHAR(1000)                 NOT NULL
);