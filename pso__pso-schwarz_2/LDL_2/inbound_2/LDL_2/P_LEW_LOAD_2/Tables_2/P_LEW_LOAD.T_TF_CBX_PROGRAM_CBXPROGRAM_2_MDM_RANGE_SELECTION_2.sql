CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_PROGRAM_CBXPROGRAM_2_MDM_RANGE_SELECTION_2
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_PROGRAM_CBXPROGRAM_CBXPROGRAM_DOCUMENTREF VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_PROG_DOC_REF                              VARCHAR(20) COLLATE 'en-ci'   NULL,
  RANGE_PLAN_CD                                 VARCHAR(20) COLLATE 'en-ci'   NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);