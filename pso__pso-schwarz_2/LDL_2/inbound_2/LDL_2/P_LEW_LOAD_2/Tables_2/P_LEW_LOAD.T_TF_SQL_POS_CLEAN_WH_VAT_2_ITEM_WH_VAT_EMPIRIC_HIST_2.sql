CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_POS_CLEAN_WH_VAT_2_ITEM_WH_VAT_EMPIRIC_HIST_2
(
  CLIENT_ID                                 NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                              VARCHAR(40)                   NOT NULL,
  CONTEXT_LOAD_ID                           NUMBER(38,0)                  NOT NULL,
  SQL_POS_CLEAN_WH_VAT_LOC_SID_WH           NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_WH_VAT_VAT_EXCEPTION        VARCHAR(900)                  NOT NULL,
  SQL_POS_CLEAN_WH_VAT_ITEM_SID             NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_WH_VAT_VAT_PCT_CALC_TYPE_ID NUMBER(10,0)                  NOT NULL,
  LOC_SID_WH                                NUMBER(38)                    NOT NULL,
  VAT_EXCEPTION                             VARCHAR(300) COLLATE 'en-ci'  NOT NULL,
  ITEM_SID                                  NUMBER(38)                    NOT NULL,
  VAT_PCT_CALC_TYPE_ID                      NUMBER(38)                    NOT NULL,
  VAT_PCT                                   NUMBER(9,5)                   NOT NULL,
  DELETED_FG                                NUMBER(38)                    NOT NULL,
  EXTRACTION_DT                             DATE                          NULL,
  DWH_MAPPING_DT                            DATE                          NOT NULL,
  TF_ERROR_FG                               NUMBER(1,0)                   NULL,
  RECORD_ID                                 VARCHAR(300)                  NOT NULL,
  FILENAME                                  VARCHAR(1000)                 NOT NULL
);