CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_FIXED_EXCHANGE_RATES_2_CACHE_FIXED_EXCHANGE_RATES_HIST_2
(
  CLIENT_ID                               NUMBER(38,0)                  NULL,
  LIDL_COUNTRY                            VARCHAR(40)                   NULL,
  FIXED_EXCHANGE_RATES_BIC_ZMLILA         VARCHAR(3) COLLATE 'en-ci'    NULL,
  FIXED_EXCHANGE_RATES_CURRENCY_ISO_CD    VARCHAR(250) COLLATE 'en-ci'  NULL,
  FIXED_EXCHANGE_RATES_TO_CURRENCY_ISO_CD VARCHAR(250) COLLATE 'en-ci'  NULL,
  FIXED_EXCHANGE_RATES_VALID_FROM_DAT     DATE                          NULL,
  BIC_ZMLILA                              VARCHAR(60)                   NULL,
  CURRENCY_ISO_CD                         VARCHAR(60)                   NULL,
  TO_CURRENCY_ISO_CD                      VARCHAR(60)                   NULL,
  VALID_FROM_DAT                          DATE                          NULL,
  VALID_TO_DAT                            DATE                          NULL,
  RATE_CURRENCY_EXCHANGE                  NUMBER(18,5)                  NULL,
  DELETED_FG                              NUMBER(38,0)                  NULL,
  EXTRACTION_DT                           DATE                          NULL,
  DWH_MAPPING_DT                          DATE                          NULL,
  TF_ERROR_FG                             NUMBER(1,0)                   NULL,
  RECORD_ID                               NUMBER(10,0)                  NULL,
  FILENAME                                VARCHAR(1000)                 NULL
);