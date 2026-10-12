CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LIL_DATA_MASK_2_LIL_DATA_MASK_1
(
  RECORD_ID                 VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  REGION_SID                NUMBER(38)                    NULL,
  PERIOD_SID                NUMBER(38)                    NULL,
  SRC_ASSORT_PARENT_CAT_CD  VARCHAR(100) COLLATE 'en-ci'  NULL,
  INTERFACE_NAME            VARCHAR(20) COLLATE 'en-ci'   NULL,
  MASK_DATA_FG              NUMBER(38)                    NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);