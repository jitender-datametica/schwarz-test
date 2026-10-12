CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_PROCESS_MSTR_LIL_GFK_CATEGORY_2_LIL_GFK_CATEGORY_2
(
  RECORD_ID           VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  GFK_CAT_SID         NUMBER(38)                    NULL,
  GFK_CAT_ID          NUMBER(38)                    NULL,
  GFK_CAT_NAME_EN     VARCHAR(100) COLLATE 'en-ci'  NULL,
  GFK_CAT_NAME_DE     VARCHAR(100) COLLATE 'en-ci'  NULL,
  GFK_CAT_SHORT_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  ACTIVE_FG           NUMBER(38)                    NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);