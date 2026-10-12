CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_LP_CUSTINFO_CONTENT_2_CUSTOMER_1
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  CUSTOMER_SID          NUMBER(38)                    NULL,
  SRC_CUSTOMERID        VARCHAR(20)                   NULL,
  LIDLPLUS_CUSTOMER_CD  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);