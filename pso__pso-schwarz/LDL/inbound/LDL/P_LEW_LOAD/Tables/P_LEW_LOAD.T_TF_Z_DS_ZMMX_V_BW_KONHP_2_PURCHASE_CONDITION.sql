CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_BW_KONHP_2_PURCHASE_CONDITION
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  Z_DS_ZMMX_V_BW_KONHP_KNUMH  VARCHAR(20)                   NULL,
  SRC_KNUMH                   VARCHAR(20)                   NULL,
  APPLICATION_CD              VARCHAR(20)                   NULL,
  CONDITION_TYPE_CD           VARCHAR(20)                   NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);