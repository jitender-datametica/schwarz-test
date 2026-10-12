CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_MARM_2_ITEM_UNIT_OF_MEASUREMENT_2
(
  CLIENT_ID       NUMBER(38)                    NULL,
  LIDL_COUNTRY    VARCHAR(40)                   NULL,
  Z_DS_MARM_MATNR VARCHAR(36)                   NULL,
  Z_DS_MARM_MEINH VARCHAR(6)                    NULL,
  SRC_MATNR       VARCHAR(40)                   NULL,
  SRC_MSEHI       VARCHAR(40)                   NULL,
  UOM_CD          VARCHAR(20)                   NULL,
  LOG_VAR_CD      VARCHAR(20)                   NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000)                 NULL
);