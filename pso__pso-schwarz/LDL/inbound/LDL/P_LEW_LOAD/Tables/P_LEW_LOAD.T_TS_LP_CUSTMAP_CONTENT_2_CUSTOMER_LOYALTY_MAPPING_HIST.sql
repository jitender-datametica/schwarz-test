CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LP_CUSTMAP_CONTENT_2_CUSTOMER_LOYALTY_MAPPING_HIST
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  CUSTOMER_SID        NUMBER(38)                    NULL,
  LOYALTY_CD          VARCHAR(100)                  NULL,
  IDENT_TYPE_CD       VARCHAR(20) COLLATE 'en-ci'   NULL,
  MAPPING_START_TMSP  TIMESTAMP_NTZ(6)              NULL,
  MAPPING_END_TMSP    TIMESTAMP_NTZ(6)              NULL,
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