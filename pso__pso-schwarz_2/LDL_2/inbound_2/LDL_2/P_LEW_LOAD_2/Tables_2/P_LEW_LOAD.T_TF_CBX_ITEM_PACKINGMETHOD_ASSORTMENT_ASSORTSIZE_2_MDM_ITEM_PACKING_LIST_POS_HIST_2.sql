CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_2_MDM_ITEM_PACKING_LIST_POS_HIST_2
(
  CLIENT_ID                                                                                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                                                            VARCHAR(40)                   NULL,
  CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_CBXITEM_DOCUMENTREF                                        VARCHAR(250)                  NULL,
  CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_CBXITEM_PACKINGMETHOD_CODE                                 VARCHAR(250)                  NULL,
  CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_CBXITEM_PACKINGMETHOD_ASSORTMENT_ITEMSTYLEUNIQUEIDS        VARCHAR(2000)                 NULL,
  CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_CBXITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_ITEMSIZE_CODE  VARCHAR(400)                  NULL,
  SRC_ITEM_DOC_REF                                                                                        VARCHAR(400)                  NULL,
  SRC_PACK_METHOD_CD                                                                                      VARCHAR(400)                  NULL,
  SRC_STYLE_UNIQIDS_CD                                                                                    VARCHAR(2000)                 NULL,
  SRC_SIZE_CD                                                                                             VARCHAR(400)                  NULL,
  PACK_LIST_POS_VERSION                                                                                   NUMBER(38)                    NULL,
  PACK_LIST_POS_PRIORITY                                                                                  NUMBER(38)                    NULL,
  PACK_LIST_POS_REQ_QTY                                                                                   NUMBER(38)                    NULL,
  PACK_LIST_POS_PACK_QTY                                                                                  NUMBER(38)                    NULL,
  DELETED_FG                                                                                              NUMBER(38)                    NULL,
  EXTRACTION_DT                                                                                           DATE                          NULL,
  DWH_MAPPING_DT                                                                                          DATE                          NULL,
  TF_ERROR_FG                                                                                             NUMBER(1,0)                   NULL,
  RECORD_ID                                                                                               NUMBER(10,0)                  NULL,
  FILENAME                                                                                                VARCHAR(1000)                 NULL
);