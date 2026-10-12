CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMFAMILYGROUP_2_ITEM_FAMILYGROUP_1
(
  CLIENT_ID                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                          VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMFAMILYGROUP_CBXITEM_ITEMFAMILYGROUP_CODE VARCHAR(250)                  NULL,
  SRC_FAMILYGRP_CD                                      VARCHAR(20)                   NULL,
  SRC_NODE                                              VARCHAR(20)                   NULL,
  SRC_FAMILYGRP_ID                                      NUMBER(38)                    NULL,
  ITEM_FAM_GRP_NAME                                     VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                         DATE                          NULL,
  DWH_MAPPING_DT                                        DATE                          NULL,
  TF_ERROR_FG                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                             NUMBER(10,0)                  NULL,
  FILENAME                                              VARCHAR(1000)                 NULL
);