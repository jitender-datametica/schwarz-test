CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LP_PROMOTIONSTORES_CONTENT_2_LIDLPLUS_PROMOTION_STORE_HIST_2
(
  CLIENT_ID                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                            VARCHAR(40)                   NULL,
  LP_PROMOTIONSTORES_CONTENT_EXTERNAL_ID  VARCHAR(100)                  NULL,
  LP_PROMOTIONSTORES_CONTENT_STORE_ID     NUMBER(38)                    NULL,
  SRC_EXTERNAL_ID                         VARCHAR(100)                  NULL,
  SRC_ORIG_STORE_NR                       NUMBER(38)                    NULL,
  VALIDITY_START_TMSP                     TIMESTAMP_NTZ(6)              NULL,
  VALIDITY_END_TMSP                       TIMESTAMP_NTZ(6)              NULL,
  DELETED_FG                              NUMBER(38)                    NULL,
  EXTRACTION_DT                           DATE                          NULL,
  DWH_MAPPING_DT                          DATE                          NULL,
  TF_ERROR_FG                             NUMBER(1,0)                   NULL,
  RECORD_ID                               NUMBER(10,0)                  NULL,
  FILENAME                                VARCHAR(1000)                 NULL
);