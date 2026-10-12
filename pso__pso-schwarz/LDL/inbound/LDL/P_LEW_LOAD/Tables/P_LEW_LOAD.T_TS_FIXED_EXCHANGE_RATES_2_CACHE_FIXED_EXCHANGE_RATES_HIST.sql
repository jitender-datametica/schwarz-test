CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_FIXED_EXCHANGE_RATES_2_CACHE_FIXED_EXCHANGE_RATES_HIST
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  BIC_ZMLILA              VARCHAR(20)                   NULL,
  CURRENCY_ISO_CD         VARCHAR(20) COLLATE 'en-ci'   NULL,
  TO_CURRENCY_ISO_CD      VARCHAR(20) COLLATE 'en-ci'   NULL,
  VALID_FROM_DAT          DATE                          NULL,
  VALID_TO_DAT            DATE                          NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,5)                  NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  DWH_VALID_FROM          DATE                          NULL,
  DWH_VALID_TO            DATE                          NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);