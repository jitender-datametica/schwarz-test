CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_HQ_MASTER_ITEM_PROPERTY_ASSIGNMENT_2_ITEM_PROPERTY_RELATION_HIST_1
(
  CLIENT_ID                                           NUMBER(38)                    NULL,
  LIDL_COUNTRY                                        VARCHAR(40) COLLATE 'en-ci'   NULL,
  HQ_MASTER_ITEM_PROPERTY_ASSIGNMENT_ITEM_NR          NUMBER(38)                    NULL,
  HQ_MASTER_ITEM_PROPERTY_ASSIGNMENT_CASE_SIZE        NUMBER(38)                    NULL,
  HQ_MASTER_ITEM_PROPERTY_ASSIGNMENT_ITEM_PROPERTY_ID NUMBER(38)                    NULL,
  DELETED_FG                                          NUMBER(38)                    NULL,
  ACTIVE_FG                                           NUMBER(38)                    NULL,
  DUMMY_FG                                            NUMBER(38)                    NULL,
  EXTRACTION_DT                                       DATE                          NULL,
  DWH_MAPPING_DT                                      DATE                          NULL,
  TF_ERROR_FG                                         NUMBER(1,0)                   NULL,
  RECORD_ID                                           NUMBER(10,0)                  NULL,
  FILENAME                                            VARCHAR(1000) COLLATE 'en-ci' NULL
);