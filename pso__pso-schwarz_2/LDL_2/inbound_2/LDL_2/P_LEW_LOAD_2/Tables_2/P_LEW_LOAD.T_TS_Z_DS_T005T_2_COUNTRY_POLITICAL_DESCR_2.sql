CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_T005T_2_COUNTRY_POLITICAL_DESCR_2
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  COUNTRY_POL_SID   NUMBER(38)                    NULL,
  LANG_SID          NUMBER(38)                    NULL,
  LANG_CD           VARCHAR(20)                   NULL,
  COUNTRY_POL_DESCR VARCHAR(100) COLLATE 'en-ci'  NULL,
  NATIONALITY       VARCHAR(300) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);