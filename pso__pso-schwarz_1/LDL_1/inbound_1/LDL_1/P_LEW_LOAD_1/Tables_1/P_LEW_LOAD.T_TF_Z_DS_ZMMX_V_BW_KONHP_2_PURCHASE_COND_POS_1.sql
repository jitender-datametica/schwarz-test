CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_BW_KONHP_2_PURCHASE_COND_POS_1
(
  CLIENT_ID                   NUMBER(38)                    NULL,
  LIDL_COUNTRY                VARCHAR(40)                   NULL,
  Z_DS_ZMMX_V_BW_KONHP_KNUMH  VARCHAR(20)                   NULL,
  Z_DS_ZMMX_V_BW_KONHP_KOPOS  NUMBER(2,0)                   NULL,
  SRC_KNUMH                   VARCHAR(40)                   NULL,
  SRC_KOPOS                   NUMBER(38)                    NULL,
  SRC_WAERS                   VARCHAR(40)                   NULL,
  CURR_CD                     VARCHAR(20)                   NULL,
  CONDITION                   NUMBER(18,5)                  NULL,
  DELETED_FG                  NUMBER(38)                    NULL,
  EXTRACTION_DT               DATE                          NULL,
  DWH_MAPPING_DT              DATE                          NULL,
  TF_ERROR_FG                 NUMBER(1,0)                   NULL,
  RECORD_ID                   NUMBER(10,0)                  NULL,
  FILENAME                    VARCHAR(1000)                 NULL
);