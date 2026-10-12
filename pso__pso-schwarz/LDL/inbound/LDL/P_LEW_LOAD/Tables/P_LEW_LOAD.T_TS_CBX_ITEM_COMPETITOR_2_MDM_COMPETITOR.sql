CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_COMPETITOR_2_MDM_COMPETITOR
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  COMPETITOR_SID    NUMBER(38)                    NULL,
  SRC_COMPETITOR_CD VARCHAR(20) COLLATE 'en-ci'   NULL,
  COMPETITOR_NAME   VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);