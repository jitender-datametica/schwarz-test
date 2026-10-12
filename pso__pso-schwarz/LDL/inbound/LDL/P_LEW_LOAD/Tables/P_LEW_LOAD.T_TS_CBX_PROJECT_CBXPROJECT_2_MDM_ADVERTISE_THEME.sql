CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_PROJECT_CBXPROJECT_2_MDM_ADVERTISE_THEME
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  MDM_AD_THEME_SID  NUMBER(38)                    NULL,
  SRC_PROJ_DOC_REF  VARCHAR(20) COLLATE 'en-ci'   NULL,
  AD_THEME_NAME     VARCHAR(100)                  NULL,
  AD_THEME_CD       VARCHAR(20) COLLATE 'en-ci'   NULL,
  AD_THEME_ID       NUMBER(20,0)                  NULL,
  BUSYEAR_AD_THEME  NUMBER(38)                    NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);