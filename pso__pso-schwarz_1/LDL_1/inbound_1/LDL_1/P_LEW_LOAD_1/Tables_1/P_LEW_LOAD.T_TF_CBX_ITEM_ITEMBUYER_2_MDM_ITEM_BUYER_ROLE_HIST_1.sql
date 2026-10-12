CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMBUYER_2_MDM_ITEM_BUYER_ROLE_HIST_1
(
  CLIENT_ID                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                  VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMBUYER_CBXITEM_DOCUMENTREF        VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMBUYER_CBXITEM_BUYER_BUYERROLE    VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMBUYER_CBXITEM_BUYER_DOCUMENTREF  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                              VARCHAR(40)                   NULL,
  SRC_USER_DOC_REF                              VARCHAR(200)                  NULL,
  ROLE_TYPE_CD                                  VARCHAR(20) COLLATE 'en-ci'   NULL,
  DELETED_FG                                    NUMBER(38)                    NULL,
  EXTRACTION_DT                                 DATE                          NULL,
  DWH_MAPPING_DT                                DATE                          NULL,
  TF_ERROR_FG                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                     NUMBER(10,0)                  NULL,
  FILENAME                                      VARCHAR(1000)                 NULL
);