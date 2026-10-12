CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_SQL_CACHE_VAT_AVG_2_POS_STORE_VAT_AVG_2
(
  CLIENT_ID                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NOT NULL,
  SQL_CACHE_VAT_AVG_LOC_SID     NUMBER(10,0)                  NOT NULL,
  SQL_CACHE_VAT_AVG_DWH_CAL_DT  DATE                          NOT NULL,
  LOC_SID                       NUMBER(38)                    NOT NULL,
  DWH_CAL_DT                    DATE                          NOT NULL,
  AVG_PCT_VAT                   NUMBER(18,5)                  NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NOT NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     VARCHAR(300)                  NOT NULL,
  FILENAME                      VARCHAR(1000)                 NOT NULL
);