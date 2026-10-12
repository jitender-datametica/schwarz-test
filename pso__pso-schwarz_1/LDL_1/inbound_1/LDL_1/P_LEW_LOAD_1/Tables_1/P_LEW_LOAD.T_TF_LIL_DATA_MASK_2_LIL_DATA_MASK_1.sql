CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_DATA_MASK_2_LIL_DATA_MASK_1
(
  CLIENT_ID                               NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                            VARCHAR(40)                   NOT NULL,
  LIL_DATA_MASK_SRC_REGION_CD             VARCHAR(250)                  NOT NULL,
  LIL_DATA_MASK_SRC_PERIOD_CD             VARCHAR(250)                  NOT NULL,
  LIL_DATA_MASK_SRC_ASSORT_PARENT_CAT_CD  VARCHAR(250)                  NOT NULL,
  LIL_DATA_MASK_INTERFACE_NAME            VARCHAR(250)                  NOT NULL,
  SRC_REGION_CD                           VARCHAR(40)                   NOT NULL,
  SRC_PERIOD_CD                           VARCHAR(40)                   NOT NULL,
  SRC_ASSORT_PARENT_CAT_CD                VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  INTERFACE_NAME                          VARCHAR(20) COLLATE 'en-ci'   NOT NULL,
  MASK_DATA_FG                            NUMBER(38)                    NOT NULL,
  EXTRACTION_DT                           DATE                          NULL,
  DWH_MAPPING_DT                          DATE                          NOT NULL,
  TF_ERROR_FG                             NUMBER(1,0)                   NULL,
  RECORD_ID                               VARCHAR(300)                  NOT NULL,
  FILENAME                                VARCHAR(1000)                 NOT NULL
);