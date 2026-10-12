CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0PURCH_ORG_TEXT_2_PURCHASE_ORG_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  PUR_ORG_SID     NUMBER(38)                    NULL,
  SRC_EKORG       VARCHAR(20)                   NULL,
  PUR_ORG_NAME    VARCHAR(100) COLLATE 'en-ci'  NULL,
  COMP_SID        NUMBER(38)                    NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);