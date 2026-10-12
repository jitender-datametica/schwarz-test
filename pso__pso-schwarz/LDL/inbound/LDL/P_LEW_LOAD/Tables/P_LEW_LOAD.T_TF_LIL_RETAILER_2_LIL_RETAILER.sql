CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_RETAILER_2_LIL_RETAILER
(
  CLIENT_ID                     NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                  VARCHAR(40)                   NOT NULL,
  LIL_RETAILER_SRC_RETAILER_CD  VARCHAR(250)                  NOT NULL,
  SRC_RETAILER_CD               VARCHAR(100)                  NOT NULL,
  RETAILER_NAME                 VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  EXTRACTION_DT                 DATE                          NULL,
  DWH_MAPPING_DT                DATE                          NOT NULL,
  TF_ERROR_FG                   NUMBER(1,0)                   NULL,
  RECORD_ID                     VARCHAR(300)                  NOT NULL,
  FILENAME                      VARCHAR(1000)                 NOT NULL
);