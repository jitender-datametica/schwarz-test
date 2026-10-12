CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MLAN_2_ITEM_TAX_COUNTRY_HIST_1
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_MLAN_MATNR   VARCHAR(36)                   NULL,
  Z_DS_MLAN_ALAND   VARCHAR(6)                    NULL,
  SRC_MATNR         VARCHAR(40)                   NULL,
  SRC_LAND1         VARCHAR(40)                   NULL,
  COUNTRY_POL_CD    VARCHAR(20)                   NULL,
  TAX_CLASS_CD      VARCHAR(20)                   NULL,
  TAX_INDICATOR_CD  VARCHAR(20)                   NULL,
  DELETED_FG        NUMBER(38)                    NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);