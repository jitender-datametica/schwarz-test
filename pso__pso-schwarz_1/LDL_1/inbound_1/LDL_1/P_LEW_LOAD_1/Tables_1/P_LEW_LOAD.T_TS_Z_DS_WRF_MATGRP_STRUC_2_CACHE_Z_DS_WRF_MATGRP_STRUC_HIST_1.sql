CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_WRF_MATGRP_STRUC_2_CACHE_Z_DS_WRF_MATGRP_STRUC_HIST_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  HIER_ID         VARCHAR(20)                   NULL,
  TREE_LEVEL      NUMBER(38)                    NULL,
  NODE            VARCHAR(20)                   NULL,
  PARENT_NODE     VARCHAR(20)                   NULL,
  DATE_FROM       DATE                          NULL,
  DATE_TO         DATE                          NULL,
  CATFLG          VARCHAR(20)                   NULL,
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