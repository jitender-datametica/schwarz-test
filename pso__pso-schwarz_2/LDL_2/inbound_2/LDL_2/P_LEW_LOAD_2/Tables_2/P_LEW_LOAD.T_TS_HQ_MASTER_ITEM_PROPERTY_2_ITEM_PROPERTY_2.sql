CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_HQ_MASTER_ITEM_PROPERTY_2_ITEM_PROPERTY_2
(
  RECORD_ID                 NUMBER(10,0)                  NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  ITEM_PROPERTY_SID         NUMBER(38)                    NULL,
  SRC_ITEM_PROPERTY_ID      NUMBER(38)                    NULL,
  SRC_ATWRT                 VARCHAR(50) COLLATE 'en-ci'   NULL,
  ITEM_PROPERTY_CD          VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_INT_NAME    VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_LOCAL_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);