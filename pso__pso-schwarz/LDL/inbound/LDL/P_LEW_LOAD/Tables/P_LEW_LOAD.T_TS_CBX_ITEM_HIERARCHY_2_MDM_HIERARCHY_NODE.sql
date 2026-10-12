CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_HIERARCHY_2_MDM_HIERARCHY_NODE
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  HIER_NODE_SID       NUMBER(38)                    NULL,
  SRC_HIERARCHY_CD    VARCHAR(20)                   NULL,
  SRC_HIER_NODE_PATH  VARCHAR(100)                  NULL,
  HIER_NODE_CD        VARCHAR(20)                   NULL,
  HIER_NODE_NAME      VARCHAR(100)                  NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);