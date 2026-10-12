CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_PROJECT_CBXPROJECT_2_MDM_ADVERTISE_THEME_HIST_2
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_PROJECT_CBXPROJECT_CBXPROJECT_DOCUMENTREF VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_PROJ_DOC_REF                              VARCHAR(40)                   NULL,
  CBX_PROJ_VERSION_NR                           NUMBER(38)                    NULL,
  CBX_PROJ_DOC_STATUS                           VARCHAR(100) COLLATE 'en-ci'  NULL,
  CBX_PROJ_CHANGE_TMSP                          TIMESTAMP_NTZ(6)              NULL,
  SRC_PROG_DOC_REF                              VARCHAR(40)                   NULL,
  AD_THEME_APPROVAL_STATUS                      VARCHAR(100) COLLATE 'en-ci'  NULL,
  AD_THEME_WORKFLOW_STATUS                      VARCHAR(100) COLLATE 'en-ci'  NULL,
  CY_WEEK_THEME_DELIVER                         NUMBER(38)                    NULL,
  CY_WEEK_THEME_ADVERTISE                       NUMBER(38)                    NULL,
  AD_THEME_SELL_FROM_DAY                        NUMBER(38)                    NULL,
  AD_THEME_SELL_FROM_DT                         DATE                          NULL,
  DELETED_FG                                    NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);