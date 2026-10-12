CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_POS_DSCNT_2_POS_DISCOUNT_2
(
  RECORD_ID           VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  DISCOUNT_SID        NUMBER(38)                    NULL,
  SRC_DISCOUNT_NR     VARCHAR(100) COLLATE 'en-ci'  NULL,
  SRC_POSART          VARCHAR(1) COLLATE 'en-ci'    NULL,
  SRC_DISCOUNT_PCT    NUMBER(18,5)                  NULL,
  DISCOUNT_DESCR      VARCHAR(100) COLLATE 'en-ci'  NULL,
  FIRST_APPEARANCE_DT DATE                          NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);