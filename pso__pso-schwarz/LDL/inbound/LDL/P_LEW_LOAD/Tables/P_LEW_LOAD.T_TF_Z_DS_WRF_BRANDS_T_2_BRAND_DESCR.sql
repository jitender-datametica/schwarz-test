CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_WRF_BRANDS_T_2_BRAND_DESCR
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  Z_DS_WRF_BRANDS_T_SPRAS   VARCHAR(4)                    NULL,
  Z_DS_WRF_BRANDS_T_KMBRND  VARCHAR(8)                    NULL,
  SRC_BRAND_CD              VARCHAR(40)                   NULL,
  BRAND_TEXT_SPRAS          VARCHAR(40)                   NULL,
  LANG_CD                   VARCHAR(20)                   NULL,
  BRAND_DESCR               VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);