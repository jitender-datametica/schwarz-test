CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMPACKTYPE_2_MDM_PACKING_METHOD_2
(
  CLIENT_ID                                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                                      VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMPACKTYPE_CBXITEM_ITEMASSORTMENT_CODE VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMPACKTYPE_CBXITEM_ITEMASSORTMENT_NAME VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMPACKTYPE_CBXITEM_ITEMPACKTYPE_CODE   VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMPACKTYPE_CBXITEM_ITEMPACKTYPE_NAME   VARCHAR(250)                  NULL,
  SRC_ASSORTMENT_CD                                 VARCHAR(20) COLLATE 'en-ci'   NULL,
  SRC_PACK_TYPE_CD                                  VARCHAR(20) COLLATE 'en-ci'   NULL,
  PACK_ASSORT_TYPE                                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  PACK_METHOD                                       VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                     DATE                          NULL,
  DWH_MAPPING_DT                                    DATE                          NULL,
  TF_ERROR_FG                                       NUMBER(1,0)                   NULL,
  RECORD_ID                                         NUMBER(10,0)                  NULL,
  FILENAME                                          VARCHAR(1000)                 NULL
);