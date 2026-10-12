CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_POS_DSCNT_2_POS_DISCOUNT_1
(
  CLIENT_ID                   NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NOT NULL,
  CONTEXT_LOAD_ID             NUMBER(38,0)                  NOT NULL,
  SQL_POS_DSCNT_DISCOUNT_NR   VARCHAR(60) COLLATE 'en-ci'   NOT NULL,
  SQL_POS_DSCNT_POSART        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  SQL_POS_DSCNT_DISCOUNT_PCT  NUMBER(23,0)                  NOT NULL,
  DISCOUNT_NR                 VARCHAR(100)                  NOT NULL,
  POSART                      VARCHAR(2)                    NOT NULL,
  DISCOUNT_PCT                NUMBER(20,0)                  NOT NULL,
  SRC_DISCOUNT_NR             VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  SRC_POSART                  VARCHAR(1) COLLATE 'en-ci'    NOT NULL,
  SRC_DISCOUNT_PCT            NUMBER(18,5)                  NOT NULL,
  DISCOUNT_DESCR              VARCHAR(100) COLLATE 'en-ci'  NULL,
  FIRST_APPEARANCE_DT         DATE                          NOT NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NOT NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   VARCHAR(300)                  NOT NULL,
  FILENAME                    VARCHAR(1000)                 NOT NULL
);