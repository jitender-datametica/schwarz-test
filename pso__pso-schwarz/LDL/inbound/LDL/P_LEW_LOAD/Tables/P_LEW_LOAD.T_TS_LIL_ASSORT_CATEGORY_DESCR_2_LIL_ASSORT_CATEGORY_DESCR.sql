CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LIL_ASSORT_CATEGORY_DESCR_2_LIL_ASSORT_CATEGORY_DESCR
(
  RECORD_ID               VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  ASSORT_CAT_SID          NUMBER(38)                    NULL,
  LANG_CD                 VARCHAR(2) COLLATE 'en-ci'    NULL,
  ASSORT_PARENT_CAT_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ASSORT_CAT_NAME         VARCHAR(300) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);