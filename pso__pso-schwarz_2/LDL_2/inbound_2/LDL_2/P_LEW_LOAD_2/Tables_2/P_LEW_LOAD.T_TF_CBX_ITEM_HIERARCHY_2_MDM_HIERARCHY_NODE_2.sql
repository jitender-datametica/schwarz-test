CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_HIERARCHY_2_MDM_HIERARCHY_NODE_2
(
  CLIENT_ID                                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                                            VARCHAR(40)                   NULL,
  CBX_ITEM_HIERARCHY_CBXITEM_HIERARCHYNODE_HIERARCHY_CODE VARCHAR(250)                  NULL,
  CBX_ITEM_HIERARCHY_CBXITEM_HIERARCHYNODE_PATH           VARCHAR(250)                  NULL,
  SRC_HIERARCHY_CD                                        VARCHAR(20)                   NULL,
  SRC_HIER_NODE_PATH                                      VARCHAR(100)                  NULL,
  HIER_NODE_CD                                            VARCHAR(20)                   NULL,
  HIER_NODE_NAME                                          VARCHAR(100)                  NULL,
  EXTRACTION_DT                                           DATE                          NULL,
  DWH_MAPPING_DT                                          DATE                          NULL,
  TF_ERROR_FG                                             NUMBER(1,0)                   NULL,
  RECORD_ID                                               NUMBER(10,0)                  NULL,
  FILENAME                                                VARCHAR(1000)                 NULL
);