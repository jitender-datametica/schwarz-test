CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_ITEMSIZE_2_MDM_ITEM_SIZE_1
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  MDM_ITEM_SIZE_SID NUMBER(38)                    NULL,
  SRC_ITEM_DOC_REF  VARCHAR(20) COLLATE 'en-ci'   NULL,
  SRC_SIZE_CD       VARCHAR(100) COLLATE 'en-ci'  NULL,
  SIZE_NAME         VARCHAR(300) COLLATE 'en-ci'  NULL,
  MDM_ITEM_SID      NUMBER(38)                    NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);