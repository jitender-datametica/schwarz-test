CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_BUYER_2_MDM_BUYER_2
(
  CLIENT_ID                                 NUMBER(38)                    NULL,
  LIDL_COUNTRY                              VARCHAR(40)                   NULL,
  CBX_ITEM_BUYER_CBXITEM_BUYER_DOCUMENTREF  VARCHAR(250)                  NULL,
  SRC_USER_DOC_REF                          VARCHAR(100) COLLATE 'en-ci'  NULL,
  CBX_USER_VERSION_NR                       NUMBER(38)                    NULL,
  BUYER_CD                                  VARCHAR(20)                   NULL,
  BUYER_FORENAME                            VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_SURNAME                             VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_EMAIL                               VARCHAR(100) COLLATE 'en-ci'  NULL,
  BUYER_NOTES                               VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                             DATE                          NULL,
  DWH_MAPPING_DT                            DATE                          NULL,
  TF_ERROR_FG                               NUMBER(1,0)                   NULL,
  RECORD_ID                                 NUMBER(10,0)                  NULL,
  FILENAME                                  VARCHAR(1000)                 NULL
);