CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_ASSORT_CATEGORY_2_LIL_ASSORT_CATEGORY_2
(
  CLIENT_ID                                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NOT NULL,
  LIL_ASSORT_CATEGORY_SRC_ASSORT_CAT_CD         VARCHAR(250)                  NOT NULL,
  LIL_ASSORT_CATEGORY_SRC_ASSORT_PARENT_CAT_CD  VARCHAR(250)                  NOT NULL,
  SRC_ASSORT_PARENT_CAT_CD                      VARCHAR(100)                  NOT NULL,
  SRC_ASSORT_CAT_CD                             VARCHAR(300)                  NOT NULL,
  ASSORT_PARENT_CAT_NAME                        VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  ASSORT_CAT_NAME                               VARCHAR(300) COLLATE 'en-ci'  NOT NULL,
  ASSORT_CAT_LEVEL                              NUMBER(38)                    NOT NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NOT NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     VARCHAR(300)                  NOT NULL,
  FILENAME                                      VARCHAR(1000)                 NOT NULL
);