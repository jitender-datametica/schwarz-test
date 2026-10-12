CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_ITEMSTYLE_2_MDM_ITEM_STYLE_HIST_2
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  MDM_ITEM_STYLE_SID  NUMBER(38)                    NULL,
  STYLE_CD            VARCHAR(20) COLLATE 'en-ci'   NULL,
  STYLE_NAME          VARCHAR(300) COLLATE 'en-ci'  NULL,
  STYLE_DESCR         VARCHAR(4000) COLLATE 'en-ci' NULL,
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