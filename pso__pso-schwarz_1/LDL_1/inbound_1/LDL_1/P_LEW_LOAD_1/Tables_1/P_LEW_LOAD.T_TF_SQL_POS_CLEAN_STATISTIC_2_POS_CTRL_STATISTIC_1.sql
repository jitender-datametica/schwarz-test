CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_POS_CLEAN_STATISTIC_2_POS_CTRL_STATISTIC_1
(
  CLIENT_ID                               NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                            VARCHAR(40)                   NOT NULL,
  SQL_POS_CLEAN_STATISTIC_LOC_SID_STORE   NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_STATISTIC_CHECKER_ID      NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_STATISTIC_POS_TERMINAL_ID NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_STATISTIC_STAT_CODE       NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_STATISTIC_DAT_FORMDATE    DATE                          NOT NULL,
  LOC_SID                                 NUMBER(38)                    NOT NULL,
  REGISTER_ID                             NUMBER(38)                    NOT NULL,
  CASHIER_ID                              NUMBER(38)                    NOT NULL,
  CASHIER_STATUS_ID                       NUMBER(38)                    NOT NULL,
  STATISTIC_ID                            NUMBER(38)                    NOT NULL,
  AUDIT_NR                                NUMBER(38)                    NOT NULL,
  STATISTIC_CNT                           NUMBER(38)                    NOT NULL,
  STATISTIC_VAL                           NUMBER(18,5)                  NOT NULL,
  DWH_CAL_DT                              DATE                          NOT NULL,
  EXTRACTION_DT                           DATE                          NULL,
  DWH_MAPPING_DT                          DATE                          NOT NULL,
  TF_ERROR_FG                             NUMBER(1,0)                   NULL,
  RECORD_ID                               VARCHAR(300)                  NOT NULL,
  FILENAME                                VARCHAR(1000)                 NOT NULL
);