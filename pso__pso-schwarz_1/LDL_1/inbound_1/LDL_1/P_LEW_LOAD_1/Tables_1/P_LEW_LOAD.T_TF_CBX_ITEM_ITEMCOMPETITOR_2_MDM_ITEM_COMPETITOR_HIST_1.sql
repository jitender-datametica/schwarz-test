CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_ITEMCOMPETITOR_2_MDM_ITEM_COMPETITOR_HIST_1
(
  CLIENT_ID                                                 NUMBER(38)                    NULL,
  LIDL_COUNTRY                                              VARCHAR(40)                   NOT NULL,
  CBX_ITEM_ITEMCOMPETITOR_CBXITEM_DOCUMENTREF               VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMCOMPETITOR_CBXITEM_COMPETITOR_CODE           VARCHAR(250)                  NULL,
  CBX_ITEM_ITEMCOMPETITOR_CBXITEM_COMPETITOR_COMPETITORSEQ  VARCHAR(250)                  NULL,
  SRC_ITEM_DOC_REF                                          VARCHAR(40)                   NULL,
  SRC_COMPETITOR_CD                                         VARCHAR(40)                   NULL,
  COMPETITOR_NR                                             NUMBER(38)                    NULL,
  SALE_PRICE                                                NUMBER(18,5)                  NULL,
  SELL_FROM_DT                                              DATE                          NULL,
  DELETED_FG                                                NUMBER(38)                    NULL,
  EXTRACTION_DT                                             DATE                          NULL,
  DWH_MAPPING_DT                                            DATE                          NULL,
  TF_ERROR_FG                                               NUMBER(1,0)                   NULL,
  RECORD_ID                                                 NUMBER(10,0)                  NULL,
  FILENAME                                                  VARCHAR(1000)                 NULL
);