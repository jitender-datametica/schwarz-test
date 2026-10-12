CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CORE_REF_LIL_LCSD_DESCR_2_REF_LIL_LCSD_DESCR_2
(
  LCSD_ID                         NUMBER(38)                    NOT NULL,
  CORE_REF_LIL_LCSD_DESCR_LANG_CD VARCHAR(250)                  NOT NULL,
  LANG_CD                         VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  LCSD_DESCR                      VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  LCSD_SHORT_DESCR                VARCHAR(100) COLLATE 'en-ci'  NULL,
  LCSD_EXPLAIN                    VARCHAR(300) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NOT NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       VARCHAR(300)                  NOT NULL,
  FILENAME                        VARCHAR(1000)                 NOT NULL
);