CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_T005_2_COUNTRY_POLITICAL
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  COUNTRY_POL_SID   NUMBER(38)                    NULL,
  SRC_LAND1         VARCHAR(20)                   NULL,
  COUNTRY_POL_NAME  VARCHAR(100) COLLATE 'en-ci'  NULL,
  CURR_SID          NUMBER(38)                    NULL,
  LANG_SID          NUMBER(38)                    NULL,
  CURR_CD           VARCHAR(20)                   NULL,
  LANG_CD           VARCHAR(20)                   NULL,
  ISO_CODE2         VARCHAR(20)                   NULL,
  ISO_CODE3         VARCHAR(20)                   NULL,
  MEMBER_EU_FG      NUMBER(38)                    NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);