CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_POS_CLEAN_VAT_AVG_2_CACHE_POS_STORE_VAT_AVG_2
(
  CLIENT_ID                           NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                        VARCHAR(40)                   NOT NULL,
  SQL_POS_CLEAN_VAT_AVG_LOC_SID_STORE NUMBER(10,0)                  NOT NULL,
  SQL_POS_CLEAN_VAT_AVG_DWH_CAL_DT    DATE                          NOT NULL,
  LOC_SID_STORE                       NUMBER(38)                    NOT NULL,
  DWH_CAL_DT                          DATE                          NOT NULL,
  LOC_SID_WH                          NUMBER(38)                    NULL,
  SALES_VAL                           NUMBER(18,5)                  NULL,
  SALES_NET_VAL                       NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_STORE                   NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_STORE_PRVS_SHADOW       NUMBER(18,5)                  NULL,
  AVG_PCT_VAT_WH                      NUMBER(18,5)                  NULL,
  EXTRACTION_DT                       DATE                          NULL,
  DWH_MAPPING_DT                      DATE                          NOT NULL,
  TF_ERROR_FG                         NUMBER(1,0)                   NULL,
  RECORD_ID                           VARCHAR(300)                  NOT NULL,
  FILENAME                            VARCHAR(1000)                 NOT NULL
);