CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZMMX_CUST14T_2_REF_RETURN_REASON_DESCR
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  RETURN_REASON_CD    VARCHAR(20)                   NULL,
  LANG_SID            NUMBER(38)                    NULL,
  LANG_CD             VARCHAR(20)                   NULL,
  RETURN_REASON_DESCR VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);