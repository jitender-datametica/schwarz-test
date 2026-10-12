CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZLAX008_CUST4T_2_PACKAGING_TYPE_1
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  PACK_TYPE_SID     NUMBER(38)                    NULL,
  SRC_ZZ_PACK_TYPE  VARCHAR(20)                   NULL,
  PACK_TYPE_NAME    VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);