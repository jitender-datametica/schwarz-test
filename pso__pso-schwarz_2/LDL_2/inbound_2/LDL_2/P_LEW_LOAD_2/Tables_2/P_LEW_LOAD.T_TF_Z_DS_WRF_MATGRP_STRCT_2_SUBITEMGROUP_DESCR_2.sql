CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_WRF_MATGRP_STRCT_2_SUBITEMGROUP_DESCR_2
(
  CLIENT_ID                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NULL,
  Z_DS_WRF_MATGRP_STRCT_HIER_ID VARCHAR(4)                    NULL,
  Z_DS_WRF_MATGRP_STRCT_NODE    VARCHAR(36)                   NULL,
  Z_DS_WRF_MATGRP_STRCT_SPRAS   VARCHAR(4)                    NULL,
  SRC_NODE                      VARCHAR(40)                   NULL,
  LANG_CD                       VARCHAR(20)                   NULL,
  SUB_ITEM_GRP_DESCR            VARCHAR(100) COLLATE 'en-ci'  NULL,
  SUB_ITEM_GRP_DESCR_LONG       VARCHAR(100) COLLATE 'en-ci'  NULL,
  SUB_ITEM_GRP_DESCR_CAPS       VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  FILENAME                      VARCHAR(1000)                 NULL
);