CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LIL_ASSORT_REGION_CAT_2_LIL_ASSORT_REGION_CAT_2
(
  RECORD_ID                 VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  REGION_SID                NUMBER(38)                    NULL,
  ASSORT_CAT_SID            NUMBER(38)                    NULL,
  ASSORT_REGION_CAT_ID      VARCHAR(27) COLLATE 'en-ci'   NULL,
  ASSORT_PARNT_CAT_NAME_DE  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ASSORT_PARNT_CAT_NAME_EN  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ASSORT_CHLD_CAT_NAME_DE   VARCHAR(100) COLLATE 'en-ci'  NULL,
  ASSORT_CHLD_CAT_NAME_EN   VARCHAR(100) COLLATE 'en-ci'  NULL,
  SEL_SRT_CD                NUMBER(38)                    NULL,
  DATA_AVBL_NOPROMO_FG      NUMBER(38)                    NULL,
  DATA_AVBL_PROMO_FG        NUMBER(38)                    NULL,
  ACTIVE_FG                 NUMBER(38)                    NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);