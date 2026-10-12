CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0VENDOR_ATTR_2_SUPPLIER_2
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  SUP_SID               NUMBER(38)                    NULL,
  SRC_LIFNR             VARCHAR(20)                   NULL,
  SRC_SUPPLIER_ID       NUMBER(38)                    NULL,
  SRC_ORIG_SUPPLIER_NR  VARCHAR(20)                   NULL,
  SUP_NAME              VARCHAR(100) COLLATE 'en-ci'  NULL,
  TAX_NO_1              VARCHAR(20)                   NULL,
  VAT_IDENT_NO          VARCHAR(20)                   NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);