CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_FIXED_EXCHANGE_RATES_2_EXCHANGE_RATE_KNOWN_HIST_2
(
  CLIENT_ID                               NUMBER(38)                    NULL,
  LIDL_COUNTRY                            VARCHAR(40)                   NULL,
  FIXED_EXCHANGE_RATES_BIC_ZMLILA         VARCHAR(3) COLLATE 'en-ci'    NULL,
  FIXED_EXCHANGE_RATES_CURRENCY_ISO_CD    VARCHAR(250) COLLATE 'en-ci'  NULL,
  FIXED_EXCHANGE_RATES_TO_CURRENCY_ISO_CD VARCHAR(250) COLLATE 'en-ci'  NULL,
  FIXED_EXCHANGE_RATES_VALID_FROM_DAT     DATE                          NULL,
  SRC_WAERS_FROM                          VARCHAR(40)                   NULL,
  SRC_WAERS_TO                            VARCHAR(40)                   NULL,
  SRC_KURST                               VARCHAR(40)                   NULL,
  ACTIVE_FROM_DT                          DATE                          NULL,
  ACTIVE_TO_DT                            DATE                          NULL,
  CURR_CD_FROM                            VARCHAR(20)                   NULL,
  CURR_CD_TO                              VARCHAR(20)                   NULL,
  EXCHANGE_RATE                           NUMBER(18,5)                  NULL,
  DELETED_FG                              NUMBER(38)                    NULL,
  EXTRACTION_DT                           DATE                          NULL,
  DWH_MAPPING_DT                          DATE                          NULL,
  TF_ERROR_FG                             NUMBER(1,0)                   NULL,
  RECORD_ID                               NUMBER(10,0)                  NULL,
  FILENAME                                VARCHAR(1000)                 NULL
);