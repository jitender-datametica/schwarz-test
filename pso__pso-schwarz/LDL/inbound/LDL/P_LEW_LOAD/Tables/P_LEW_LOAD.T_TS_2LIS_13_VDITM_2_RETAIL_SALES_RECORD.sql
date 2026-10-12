CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_2LIS_13_VDITM_2_RETAIL_SALES_RECORD
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  RETAIL_SALES_RECORD_ID  NUMBER(20,0)                  NULL,
  CURR_SID                NUMBER(38)                    NULL,
  CURR_CD                 VARCHAR(20)                   NULL,
  INVOICE_CLASS_CD        VARCHAR(20)                   NULL,
  INVOICE_TYPE_CD         VARCHAR(20)                   NULL,
  DWH_CAL_DT              DATE                          NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);