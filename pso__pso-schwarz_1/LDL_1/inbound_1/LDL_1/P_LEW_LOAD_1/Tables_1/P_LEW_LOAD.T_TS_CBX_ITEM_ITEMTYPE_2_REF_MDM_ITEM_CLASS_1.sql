CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_ITEMTYPE_2_REF_MDM_ITEM_CLASS_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_CLASS_CD   VARCHAR(20) COLLATE 'en-ci'   NULL,
  ITEM_CLASS      VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);