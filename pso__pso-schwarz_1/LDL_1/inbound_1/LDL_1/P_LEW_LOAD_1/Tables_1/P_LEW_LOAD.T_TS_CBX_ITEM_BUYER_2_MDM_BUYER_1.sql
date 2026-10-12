CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_BUYER_2_MDM_BUYER_1
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  BUYER_SID           NUMBER(38)                    NULL,
  SRC_USER_DOC_REF    VARCHAR(100) COLLATE 'en-ci'  NULL,
  CBX_USER_VERSION_NR NUMBER(38)                    NULL,
  BUYER_CD            VARCHAR(20)                   NULL,
  BUYER_FORENAME      VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_SURNAME       VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_EMAIL         VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_NOTES         VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);