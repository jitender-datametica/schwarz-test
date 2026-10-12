CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_MXXD2016_2_ITEM_LOCATION_BRAND_HIST
(
  RECORD_ID         NUMBER(10,0)                  NULL,
  CLIENT_ID         NUMBER(38)                    NULL,
  ITEM_SID          NUMBER(38)                    NULL,
  LOC_SID           NUMBER(38)                    NULL,
  BRAND_SID         NUMBER(38)                    NULL,
  BRAND_TYPE_MARK   VARCHAR(20) COLLATE 'en-ci'   NULL,
  BRAND_TYPE_LABEL  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG        NUMBER(38)                    NULL,
  DWH_VALID_FROM    DATE                          NULL,
  DWH_VALID_TO      DATE                          NULL,
  DWH_LOAD_ID       NUMBER(38)                    NULL,
  DWH_CREATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED       TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  ERROR_FG          NUMBER(38)                    NULL,
  ERROR_DESCR       VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME          VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO       NUMBER(38)                    NULL
);