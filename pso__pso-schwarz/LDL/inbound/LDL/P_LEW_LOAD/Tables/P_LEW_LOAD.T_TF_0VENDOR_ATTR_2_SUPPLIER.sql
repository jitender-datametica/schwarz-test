CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0VENDOR_ATTR_2_SUPPLIER
(
  CLIENT_ID             NUMBER(38)                    NULL,
  LIDL_COUNTRY          VARCHAR(40)                   NULL,
  VENDOR_ATTR_LIFNR     VARCHAR(20)                   NULL,
  SRC_LIFNR             VARCHAR(20)                   NULL,
  SRC_SUPPLIER_ID       NUMBER(38)                    NULL,
  SRC_ORIG_SUPPLIER_NR  VARCHAR(20)                   NULL,
  SUP_NAME              VARCHAR(100) COLLATE 'en-ci'  NULL,
  TAX_NO_1              VARCHAR(20)                   NULL,
  VAT_IDENT_NO          VARCHAR(20)                   NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000)                 NULL
);