CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LIL_TRANSLATION_2_LIL_TRANSLATION
(
  RECORD_ID       VARCHAR(1000) COLLATE 'en-ci' NULL,
  CONTEXT         VARCHAR(100) COLLATE 'en-ci'  NULL,
  TRANS_ID        NUMBER(38)                    NULL,
  SRC_TRANS_CD    VARCHAR(100)                  NULL,
  LANG_CD         VARCHAR(2) COLLATE 'en-ci'    NULL,
  ORIG_TEXT       VARCHAR(100)                  NULL,
  TRANS_TEXT      VARCHAR(100)                  NULL,
  ACTIVE_FG       NUMBER(38)                    NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);