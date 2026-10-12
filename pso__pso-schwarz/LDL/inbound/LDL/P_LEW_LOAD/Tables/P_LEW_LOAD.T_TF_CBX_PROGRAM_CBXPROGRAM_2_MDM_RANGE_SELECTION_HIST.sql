CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_PROGRAM_CBXPROGRAM_2_MDM_RANGE_SELECTION_HIST
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_PROGRAM_CBXPROGRAM_CBXPROGRAM_DOCUMENTREF VARCHAR(250) COLLATE 'en-ci'  NULL,
  SRC_PROG_DOC_REF                              VARCHAR(40)                   NULL,
  CBX_PROG_VERSION_NR                           NUMBER(38)                    NULL,
  CBX_PROG_DOC_STATUS                           VARCHAR(100) COLLATE 'en-ci'  NULL,
  CBX_PROG_CHANGE_TMSP                          TIMESTAMP_NTZ(6)              NULL,
  RANGE_SELECTION_ACTIVE_FG                     NUMBER(38)                    NULL,
  CY_MONTH_RANGE_SELECTION                      NUMBER(38)                    NULL,
  RANGE_SELECTION_END_DT                        DATE                          NULL,
  CY_WEEK_RANGE_DELIVER_FROM                    NUMBER(38)                    NULL,
  CY_WEEK_RANGE_DELIVER_TO                      NUMBER(38)                    NULL,
  CY_WEEK_RANGE_ADVERTISE_FROM                  NUMBER(38)                    NULL,
  CY_WEEK_RANGE_ADVERTISE_TO                    NUMBER(38)                    NULL,
  DELETED_FG                                    NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);