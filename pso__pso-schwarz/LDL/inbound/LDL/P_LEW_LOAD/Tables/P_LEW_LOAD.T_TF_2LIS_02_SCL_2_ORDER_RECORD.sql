CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_2LIS_02_SCL_2_ORDER_RECORD
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  LIS_02_SCL_EBELN  VARCHAR(20)                   NULL,
  ORDER_RECORD_ID   NUMBER(20,0)                  NULL,
  SRC_LIFNR         VARCHAR(40)                   NULL,
  SRC_WERKS         VARCHAR(40)                   NULL,
  ORDER_TYPE_CD     VARCHAR(20)                   NULL,
  DWH_CAL_DT        DATE                          NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);