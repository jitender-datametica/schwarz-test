CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_T002_2_REPORT_LANGUAGE
(
  SRC_SPRAS       VARCHAR(20)                   NULL,
  LANG_NAME       VARCHAR(100) COLLATE 'en-ci'  NULL,
  Z_DS_T002_SPRAS VARCHAR(2)                    NULL,
  ISO_CD          VARCHAR(20)                   NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000)                 NULL
);