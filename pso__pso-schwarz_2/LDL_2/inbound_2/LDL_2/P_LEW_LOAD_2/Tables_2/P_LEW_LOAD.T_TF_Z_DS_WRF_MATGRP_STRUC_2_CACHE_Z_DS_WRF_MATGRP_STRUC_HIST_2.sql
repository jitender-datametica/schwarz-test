CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_WRF_MATGRP_STRUC_2_CACHE_Z_DS_WRF_MATGRP_STRUC_HIST_2
(
  CLIENT_ID                       NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  Z_DS_WRF_MATGRP_STRUC_HIER_ID   VARCHAR(4)                    NULL,
  Z_DS_WRF_MATGRP_STRUC_NODE      VARCHAR(36)                   NULL,
  Z_DS_WRF_MATGRP_STRUC_DATE_FROM DATE                          NULL,
  BIC_ZMLILA                      VARCHAR(60)                   NULL,
  HIER_ID                         VARCHAR(60)                   NULL,
  TREE_LEVEL                      NUMBER(38,0)                  NULL,
  NODE                            VARCHAR(60)                   NULL,
  PARENT_NODE                     VARCHAR(60)                   NULL,
  DATE_FROM                       DATE                          NULL,
  DATE_TO                         DATE                          NULL,
  CATFLG                          VARCHAR(60)                   NULL,
  DELETED_FG                      NUMBER(38,0)                  NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);