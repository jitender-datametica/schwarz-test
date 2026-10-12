CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_CBX_ITEM_SUPPLIER_EANOWNERSHIP_2_REF_MDM_EAN_OWNERSHIP_1
(
  CLIENT_ID                                                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                                                      VARCHAR(40)                   NULL,
  CBX_ITEM_SUPPLIER_EANOWNERSHIP_CBXITEM_SUPPLIER_EANOWNERSHIP_CODE VARCHAR(250)                  NULL,
  EAN_OWNERSHIP_CD                                                  VARCHAR(20) COLLATE 'en-ci'   NULL,
  EAN_OWNERSHIP                                                     VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                                                     DATE                          NULL,
  DWH_MAPPING_DT                                                    DATE                          NULL,
  TF_ERROR_FG                                                       NUMBER(1,0)                   NULL,
  RECORD_ID                                                         NUMBER(10,0)                  NULL,
  FILENAME                                                          VARCHAR(1000)                 NULL
);