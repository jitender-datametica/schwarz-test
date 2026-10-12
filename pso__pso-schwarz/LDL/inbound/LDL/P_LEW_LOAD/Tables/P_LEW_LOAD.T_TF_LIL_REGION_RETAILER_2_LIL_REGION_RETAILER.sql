CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_LIL_REGION_RETAILER_2_LIL_REGION_RETAILER
(
  CLIENT_ID                           NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                        VARCHAR(40)                   NOT NULL,
  LIL_REGION_RETAILER_SRC_REGION_CD   VARCHAR(250)                  NOT NULL,
  LIL_REGION_RETAILER_SRC_RETAILER_CD VARCHAR(250)                  NOT NULL,
  SRC_REGION_CD                       VARCHAR(200)                  NOT NULL,
  SRC_RETAILER_CD                     VARCHAR(200)                  NOT NULL,
  RTL_ID                              NUMBER(38)                    NOT NULL,
  REGION_RTL_DESC_DE                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  REGION_RTL_DESC_EN                  VARCHAR(100) COLLATE 'en-ci'  NULL,
  RTL_LVL                             NUMBER(38)                    NOT NULL,
  ACTIVE_FG                           NUMBER(38)                    NULL,
  EXTRACTION_DT                       DATE                          NULL,
  DWH_MAPPING_DT                      DATE                          NOT NULL,
  TF_ERROR_FG                         NUMBER(1,0)                   NULL,
  RECORD_ID                           VARCHAR(300)                  NOT NULL,
  FILENAME                            VARCHAR(1000)                 NOT NULL
);