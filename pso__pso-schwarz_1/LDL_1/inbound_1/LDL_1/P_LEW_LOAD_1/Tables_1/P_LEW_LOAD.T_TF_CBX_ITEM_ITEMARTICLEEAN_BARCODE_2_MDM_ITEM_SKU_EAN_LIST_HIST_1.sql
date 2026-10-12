CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMARTICLEEAN_BARCODE_2_MDM_ITEM_SKU_EAN_LIST_HIST_1
(
  CLIENT_ID                                                     NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                  VARCHAR(40)                   NULL,
  CBX_ITEM_ITEMARTICLEEAN_CBXITEM_DOCUMENTREF                   VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMARTICLEEAN_CBXITEM_ARTICLEEAN_BARCODE            VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMARTICLEEAN_CBXITEM_ARTICLEEAN_ITEMSTYLEUNIQUEIDS VARCHAR(2000)                 NULL,
  CBX_ITEM_ITEMARTICLEEAN_CBXITEM_ARTICLEEAN_ITEMLSV_CODE       VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMARTICLEEAN_CBXITEM_ARTICLEEAN_ITEMSIZE_CODE      VARCHAR(300)                  NULL,
  SRC_ITEM_DOC_REF                                              VARCHAR(40)                   NULL,
  SRC_STYLE_UNIQIDS_CD                                          VARCHAR(2000)                 NULL,
  SRC_SIZE_CD                                                   VARCHAR(300)                  NULL,
  SRC_VARIANT_CD                                                VARCHAR(40)                   NULL,
  BARCODE                                                       VARCHAR(20) COLLATE 'en-ci'   NOT NULL,
  DELETED_FG                                                    NUMBER(38)                    NULL,
  EXTRACTION_DT                                                 DATE                          NULL,
  DWH_MAPPING_DT                                                DATE                          NULL,
  TF_ERROR_FG                                                   NUMBER(1,0)                   NULL,
  RECORD_ID                                                     NUMBER(10,0)                  NULL,
  FILENAME                                                      VARCHAR(1000)                 NULL
);