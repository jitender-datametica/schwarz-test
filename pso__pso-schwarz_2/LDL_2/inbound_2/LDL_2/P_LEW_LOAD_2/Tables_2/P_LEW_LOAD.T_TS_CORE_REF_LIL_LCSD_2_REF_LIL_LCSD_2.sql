CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CORE_REF_LIL_LCSD_2_REF_LIL_LCSD_2
(
  RECORD_ID         VARCHAR(1000) COLLATE 'en-ci' NULL,
  LCSD_ID           NUMBER(38)                    NULL,
  LCSD_CD           VARCHAR(100)                  NULL,
  LCSD_DESCR        VARCHAR(100) COLLATE 'en-ci'  NULL,
  LCSD_SHORT_DESCR  VARCHAR(100) COLLATE 'en-ci'  NULL,
  LCSD_EXPLAIN      VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);