CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMFAMILYGROUP_2_ITEM_FAMILYGROUP_DESCR_1
(
  CLIENT_ID                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                          VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMFAMILYGROUP_CBXITEM_ITEMFAMILYGROUP_CODE VARCHAR(250)                  NULL,
  SRC_FAMILYGRP_CD                                      VARCHAR(40)                   NULL,
  LANG_CD                                               VARCHAR(20)                   NULL,
  ITEM_FAM_GRP_DESCR                                    VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_FAM_GRP_DESCR_LONG                               VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_FAM_GRP_DESCR_CAPS                               VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                         DATE                          NULL,
  DWH_MAPPING_DT                                        DATE                          NULL,
  TF_ERROR_FG                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                             NUMBER(10,0)                  NULL,
  FILENAME                                              VARCHAR(1000)                 NULL
);