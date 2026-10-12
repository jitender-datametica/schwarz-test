CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_2LIS_13_VDITM_2_RETAIL_SALES_RECORD
(
  CLIENT_ID               NUMBER(38)                    NULL,
  LIDL_COUNTRY            VARCHAR(40)                   NULL,
  LIS_13_VDITM_VBELN      VARCHAR(20)                   NULL,
  RETAIL_SALES_RECORD_ID  NUMBER(20,0)                  NULL,
  SRC_WAERS               VARCHAR(40)                   NULL,
  CURR_CD                 VARCHAR(20)                   NULL,
  INVOICE_CLASS_CD        VARCHAR(20)                   NULL,
  INVOICE_TYPE_CD         VARCHAR(20)                   NULL,
  DWH_CAL_DT              DATE                          NULL,
  EXTRACTION_DT           DATE                          NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  TF_ERROR_FG             NUMBER(1,0)                   NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  FILENAME                VARCHAR(1000)                 NULL
);