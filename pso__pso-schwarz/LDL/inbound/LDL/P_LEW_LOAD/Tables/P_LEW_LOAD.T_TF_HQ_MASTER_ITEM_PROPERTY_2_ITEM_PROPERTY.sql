CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_HQ_MASTER_ITEM_PROPERTY_2_ITEM_PROPERTY
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40) COLLATE 'en-ci'   NULL,
  HQ_MASTER_ITEM_PROPERTY_SRC_ITEM_PROPERTY_ID  NUMBER(38)                    NULL,
  SRC_ITEM_PROPERTY_ID                          NUMBER(38)                    NULL,
  SRC_ATWRT                                     VARCHAR(50) COLLATE 'en-ci'   NULL,
  ITEM_PROPERTY_CD                              VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_INT_NAME                        VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_LOCAL_NAME                      VARCHAR(100) COLLATE 'en-ci'  NULL,
  ITEM_PROPERTY_DESCR                           VARCHAR(1000) COLLATE 'en-ci' NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000) COLLATE 'en-ci' NULL
);