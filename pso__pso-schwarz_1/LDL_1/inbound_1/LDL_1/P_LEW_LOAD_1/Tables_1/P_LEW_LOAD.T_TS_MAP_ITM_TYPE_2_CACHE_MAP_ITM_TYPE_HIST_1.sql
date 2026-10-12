CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_MAP_ITM_TYPE_2_CACHE_MAP_ITM_TYPE_HIST_1
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  BIC_ZMLILA            VARCHAR(20)                   NULL,
  DESCR                 VARCHAR(100)                  NULL,
  LIST_TYPE_CD          VARCHAR(20)                   NULL,
  BUYING_LIST_TYPE_ID   NUMBER(38)                    NULL,
  BUYING_LIST_TYPE_DESC VARCHAR(100)                  NULL,
  DELETED_FG            NUMBER(38)                    NULL,
  DWH_VALID_FROM        DATE                          NULL,
  DWH_VALID_TO          DATE                          NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);