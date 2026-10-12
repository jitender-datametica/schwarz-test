CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_GFK_CATEGORY_2_LIL_GFK_CATEGORY
(
  CLIENT_ID                                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NOT NULL,
  PROCESS_MSTR_LIL_GFK_CATEGORY_SRC_GFK_CAT_CD  VARCHAR(250)                  NOT NULL,
  SRC_GFK_CAT_CD                                VARCHAR(200)                  NOT NULL,
  GFK_CAT_ID                                    NUMBER(38)                    NOT NULL,
  GFK_CAT_NAME_EN                               VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  GFK_CAT_NAME_DE                               VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  GFK_CAT_SHORT_NAME                            VARCHAR(100) COLLATE 'en-ci'  NULL,
  ACTIVE_FG                                     NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NOT NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     VARCHAR(300)                  NOT NULL,
  FILENAME                                      VARCHAR(1000)                 NOT NULL
);