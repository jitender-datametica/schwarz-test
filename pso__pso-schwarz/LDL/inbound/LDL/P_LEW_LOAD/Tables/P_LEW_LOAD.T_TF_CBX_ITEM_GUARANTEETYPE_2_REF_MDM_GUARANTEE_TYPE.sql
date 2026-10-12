CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_GUARANTEETYPE_2_REF_MDM_GUARANTEE_TYPE
(
  CLIENT_ID                                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                                      VARCHAR(40)                   NULL,
  CBX_ITEM_GUARANTEETYPE_CBXITEM_GUARANTEETYPE_CODE VARCHAR(250)                  NULL,
  GUARANTEE_TYPE_CD                                 VARCHAR(100) COLLATE 'en-ci'  NULL,
  GUARANTEE_TYPE_DESCR                              VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                     DATE                          NULL,
  DWH_MAPPING_DT                                    DATE                          NULL,
  TF_ERROR_FG                                       NUMBER(1,0)                   NULL,
  RECORD_ID                                         NUMBER(10,0)                  NULL,
  FILENAME                                          VARCHAR(1000)                 NULL
);