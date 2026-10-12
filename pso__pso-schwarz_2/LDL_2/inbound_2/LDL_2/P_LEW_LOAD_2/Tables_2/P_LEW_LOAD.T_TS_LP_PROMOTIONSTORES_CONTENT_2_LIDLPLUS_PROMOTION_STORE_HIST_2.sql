CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LP_PROMOTIONSTORES_CONTENT_2_LIDLPLUS_PROMOTION_STORE_HIST_2
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDLPLUS_PROM_SID   NUMBER(38)                    NULL,
  LOC_SID_STORE       NUMBER(38)                    NULL,
  VALIDITY_START_TMSP TIMESTAMP_NTZ(6)              NULL,
  VALIDITY_END_TMSP   TIMESTAMP_NTZ(6)              NULL,
  DELETED_FG          NUMBER(38)                    NULL,
  DWH_VALID_FROM      DATE                          NULL,
  DWH_VALID_TO        DATE                          NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);