CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_PERIOD_2_LIL_PERIOD
(
  CLIENT_ID                             NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NOT NULL,
  PROCESS_MSTR_LIL_PERIOD_SRC_PERIOD_CD VARCHAR(250)                  NOT NULL,
  SRC_PERIOD_CD                         VARCHAR(40)                   NOT NULL,
  PERIOD_ID                             NUMBER(38)                    NOT NULL,
  PERIOD_LVL                            NUMBER(38)                    NOT NULL,
  LIAM_AVBL_FG                          NUMBER(38)                    NULL,
  LIFT_AVBL_FG                          NUMBER(38)                    NULL,
  ACTIVE_FG                             NUMBER(38)                    NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NOT NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             VARCHAR(300)                  NOT NULL,
  FILENAME                              VARCHAR(1000)                 NOT NULL
);