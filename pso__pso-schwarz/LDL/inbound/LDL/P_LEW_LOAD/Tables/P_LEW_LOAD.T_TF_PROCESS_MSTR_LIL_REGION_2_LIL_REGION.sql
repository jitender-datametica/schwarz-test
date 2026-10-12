CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_REGION_2_LIL_REGION
(
  CLIENT_ID                             NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NOT NULL,
  PROCESS_MSTR_LIL_REGION_SRC_REGION_CD VARCHAR(250)                  NOT NULL,
  SRC_REGION_CD                         VARCHAR(100)                  NOT NULL,
  REGION_ID                             NUMBER(38,0)                  NOT NULL,
  REGION_NAME_EN                        VARCHAR(300)                  NULL,
  REGION_NAME_DE                        VARCHAR(300)                  NULL,
  REGION_SHORT_DESC                     VARCHAR(300)                  NULL,
  REGION_LONG_DESC                      VARCHAR(300)                  NULL,
  REGION_SRT_CD                         NUMBER(38,0)                  NULL,
  QR_SRT_CD                             NUMBER(38,0)                  NULL,
  REGION_LVL                            NUMBER(38,0)                  NULL,
  SD_CHLD_BELOW_12                      VARCHAR(300)                  NULL,
  SD_CHLD_OVER_12                       VARCHAR(300)                  NULL,
  ACTIVE_FG                             NUMBER(38,0)                  NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NOT NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             VARCHAR(300)                  NOT NULL,
  FILENAME                              VARCHAR(1000)                 NOT NULL
);