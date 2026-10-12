CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_2LIS_13_VDITM_2_SALES_INVOICE_RECORD
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  LIS_13_VDITM_VBELN          VARCHAR(20)                   NULL,
  SALES_INVOICE_RECORD_CD     VARCHAR(20)                   NULL,
  SRC_WAERS                   VARCHAR(40)                   NULL,
  SRC_VKORG                   VARCHAR(40)                   NULL,
  SRC_LAND1_DELIVERY          VARCHAR(40)                   NULL,
  COUNTRY_POL_CD_DELIVERY     VARCHAR(20)                   NULL,
  INVOICE_CLASS_CD            VARCHAR(20)                   NULL,
  INVOICE_TYPE_CD             VARCHAR(20)                   NULL,
  CURR_CD                     VARCHAR(20)                   NULL,
  NET_TOTAL_VAL               NUMBER(18,5)                  NULL,
  REF_SALES_INVOICE_RECORD_CD VARCHAR(20)                   NULL,
  DWH_CAL_DT                  DATE                          NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);