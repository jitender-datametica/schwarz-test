CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0RT_WRF3_ATTR_2_STORE_TO_WH_DELIVERY_HIST_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  RT_WRF3_ATTR_WERKS  VARCHAR(8)                    NULL,
  RT_WRF3_ATTR_MATKL  VARCHAR(18)                   NULL,
  RT_WRF3_ATTR_LOCLB  VARCHAR(8)                    NULL,
  RT_WRF3_ATTR_DATBI  DATE                          NULL,
  SRC_WERKS_STORE     VARCHAR(40)                   NULL,
  SRC_WERKS_WH        VARCHAR(40)                   NULL,
  SRC_MATKL           VARCHAR(40)                   NULL,
  ITEM_GRP_CD         VARCHAR(20)                   NULL,
  PRIORITY            NUMBER(38)                    NULL,
  ACTIVE_FROM_DT      DATE                          NULL,
  ACTIVE_TO_DT        DATE                          NULL,
  DELETED_FG          NUMBER(38)                    NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);