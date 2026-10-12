CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_WRF_MATGRP_STRUC_2_SUBITEMGROUP_HIST
(
  CLIENT_ID                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  Z_DS_WRF_MATGRP_STRUC_HIER_ID   VARCHAR(4)                    NULL,
  Z_DS_WRF_MATGRP_STRUC_NODE      VARCHAR(36)                   NULL,
  Z_DS_WRF_MATGRP_STRUC_DATE_FROM DATE                          NULL,
  SRC_NODE_SUIG                   VARCHAR(40)                   NULL,
  SRC_NODE_IGRI                   VARCHAR(40)                   NULL,
  ITEM_GRP_INT_CD                 VARCHAR(20)                   NULL,
  MAIN_ITEM_GRP_CD                VARCHAR(20)                   NULL,
  DELETED_FG                      NUMBER(38)                    NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);