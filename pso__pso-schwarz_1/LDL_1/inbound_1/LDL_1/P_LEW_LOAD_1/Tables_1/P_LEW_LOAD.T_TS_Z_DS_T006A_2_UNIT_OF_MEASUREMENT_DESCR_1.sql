CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_T006A_2_UNIT_OF_MEASUREMENT_DESCR_1
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  UOM_SID           NUMBER(38)                    NULL,
  LANG_SID          NUMBER(38)                    NULL,
  UOM_CD            VARCHAR(20)                   NULL,
  LANG_CD           VARCHAR(20)                   NULL,
  UOM_DESCR_SHORT   VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_DESCR_LONG    VARCHAR(300) COLLATE 'en-ci'  NULL,
  UOM_DESCR_EXT_3CH VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_DESCR_EXT_6CH VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);