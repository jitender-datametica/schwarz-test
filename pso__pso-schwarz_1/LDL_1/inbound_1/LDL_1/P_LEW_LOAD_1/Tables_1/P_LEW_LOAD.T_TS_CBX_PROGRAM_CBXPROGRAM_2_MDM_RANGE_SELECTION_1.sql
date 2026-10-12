CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_PROGRAM_CBXPROGRAM_2_MDM_RANGE_SELECTION_1
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  MDM_RANGE_SEL_SID NUMBER(38)                    NULL,
  SRC_PROG_DOC_REF  VARCHAR(20) COLLATE 'en-ci'   NULL,
  RANGE_PLAN_CD     VARCHAR(20) COLLATE 'en-ci'   NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);