CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_PROJECT_CBXPROJECT_2_MDM_ADVERTISE_THEME_1
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_PROJECT_CBXPROJECT_CBXPROJECT_DOCUMENTREF VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_PROJ_DOC_REF                              VARCHAR(20) COLLATE 'en-ci'   NULL,
  AD_THEME_NAME                                 VARCHAR(100)                  NULL,
  AD_THEME_CD                                   VARCHAR(20) COLLATE 'en-ci'   NULL,
  AD_THEME_ID                                   NUMBER(20,0)                  NULL,
  BUSYEAR_AD_THEME                              NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);