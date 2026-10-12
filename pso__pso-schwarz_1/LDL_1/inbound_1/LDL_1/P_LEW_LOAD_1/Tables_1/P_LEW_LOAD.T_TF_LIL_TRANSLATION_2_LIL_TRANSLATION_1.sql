CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_TRANSLATION_2_LIL_TRANSLATION_1
(
  CONTEXT                   VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  LIL_TRANSLATION_CONTEXT   VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  LIL_TRANSLATION_TRANS_ID  NUMBER(38,0)                  NOT NULL,
  LIL_TRANSLATION_LANG_CD   VARCHAR(250)                  NOT NULL,
  TRANS_ID                  NUMBER(38)                    NOT NULL,
  SRC_TRANS_CD              VARCHAR(100)                  NOT NULL,
  LANG_CD                   VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  ORIG_TEXT                 VARCHAR(100)                  NOT NULL,
  TRANS_TEXT                VARCHAR(100)                  NOT NULL,
  ACTIVE_FG                 NUMBER(38)                    NOT NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NOT NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 VARCHAR(300)                  NOT NULL,
  FILENAME                  VARCHAR(1000)                 NOT NULL
);