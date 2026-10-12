CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_MEAN_2_ITEM_GTIN_HIST
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  ITEM_SID        NUMBER(38)                    NULL,
  UOM_SID         NUMBER(38)                    NULL,
  SEQ_NR          VARCHAR(20)                   NULL,
  UOM_CD          VARCHAR(20)                   NULL,
  GTIN            VARCHAR(20)                   NULL,
  GTIN_TYPE_MARK  VARCHAR(20)                   NULL,
  GTIN_TYPE_LABEL VARCHAR(100)                  NULL,
  MAIN_GTIN_FG    NUMBER(38)                    NULL,
  DELETED_FG      NUMBER(38)                    NULL,
  DWH_VALID_FROM  DATE                          NULL,
  DWH_VALID_TO    DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);