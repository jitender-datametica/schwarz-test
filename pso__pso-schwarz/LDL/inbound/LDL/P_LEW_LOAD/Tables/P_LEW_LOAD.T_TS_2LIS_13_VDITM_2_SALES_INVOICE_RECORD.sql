CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_2LIS_13_VDITM_2_SALES_INVOICE_RECORD
(
  RECORD_ID                   NUMBER(10,0)                  NULL,
  CLIENT_ID                   NUMBER(38)                    NULL,
  SALES_INVOICE_RECORD_CD     VARCHAR(20)                   NULL,
  CURR_SID                    NUMBER(38)                    NULL,
  SALES_ORG_SID               NUMBER(38)                    NULL,
  COUNTRY_POL_SID_DELIVERY    NUMBER(38)                    NULL,
  COUNTRY_POL_CD_DELIVERY     VARCHAR(20)                   NULL,
  INVOICE_CLASS_CD            VARCHAR(20)                   NULL,
  INVOICE_TYPE_CD             VARCHAR(20)                   NULL,
  CURR_CD                     VARCHAR(20)                   NULL,
  NET_TOTAL_VAL               NUMBER(18,5)                  NULL,
  REF_SALES_INVOICE_RECORD_CD VARCHAR(20)                   NULL,
  DWH_CAL_DT                  DATE                          NULL,
  DWH_LOAD_ID                 NUMBER(38)                    NULL,
  DWH_CREATED                 TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED                 TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  ERROR_FG                    NUMBER(38)                    NULL,
  ERROR_DESCR                 VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                    VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO                 NUMBER(38)                    NULL
);