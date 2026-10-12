CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_MAP_ITM_MISSING_STATE_2_CACHE_MAP_ITM_MISSING_STATE_HIST_2
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  BIC_ZMLILA            VARCHAR(20)                   NULL,
  ITM_STATE_BGES_ID     VARCHAR(20)                   NULL,
  ITM_MISSING_STATE     VARCHAR(100)                  NULL,
  ITM_MISSING_REASON_CD VARCHAR(20)                   NULL,
  ITEM_STATUS_PP_MIS    VARCHAR(100)                  NULL,
  END_CD_PP_MIS         VARCHAR(20)                   NULL,
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