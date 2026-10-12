CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMFAMILYGROUP_2_ITEM_FAMILYGROUP_HIST_1
(
  CLIENT_ID                                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                                          VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMFAMILYGROUP_CBXITEM_ITEMFAMILYGROUP_CODE VARCHAR(250)                  NULL,
  SRC_FAMILYGRP_CD                                      VARCHAR(40)                   NULL,
  DUMMY_NO_LOOKUP                                       VARCHAR(40)                   NULL,
  SUB_ITEM_GRP_CD                                       VARCHAR(20)                   NULL,
  DELETED_FG                                            NUMBER(38)                    NULL,
  EXTRACTION_DT                                         DATE                          NULL,
  DWH_MAPPING_DT                                        DATE                          NULL,
  TF_ERROR_FG                                           NUMBER(1,0)                   NULL,
  RECORD_ID                                             NUMBER(10,0)                  NULL,
  FILENAME                                              VARCHAR(1000)                 NULL
);