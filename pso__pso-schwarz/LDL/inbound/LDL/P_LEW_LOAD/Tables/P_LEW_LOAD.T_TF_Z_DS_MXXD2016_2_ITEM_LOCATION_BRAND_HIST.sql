CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MXXD2016_2_ITEM_LOCATION_BRAND_HIST
(
  CLIENT_ID               NUMBER(38)                    NULL,
  LIDL_COUNTRY            VARCHAR(40)                   NULL,
  Z_DS_MXXD2016_PLANT     VARCHAR(8)                    NULL,
  Z_DS_MXXD2016_MATERIAL  VARCHAR(36)                   NULL,
  SRC_MATNR               VARCHAR(40)                   NULL,
  SRC_WERKS               VARCHAR(40)                   NULL,
  SRC_BRAND_CD            VARCHAR(40)                   NULL,
  BRAND_TYPE_MARK         VARCHAR(20) COLLATE 'en-ci'   NULL,
  BRAND_TYPE_LABEL        VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  EXTRACTION_DT           DATE                          NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  TF_ERROR_FG             NUMBER(1,0)                   NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  FILENAME                VARCHAR(1000)                 NULL
);