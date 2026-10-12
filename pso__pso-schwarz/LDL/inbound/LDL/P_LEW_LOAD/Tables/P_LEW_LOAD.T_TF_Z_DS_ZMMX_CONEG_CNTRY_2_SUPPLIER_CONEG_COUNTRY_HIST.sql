CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_CONEG_CNTRY_2_SUPPLIER_CONEG_COUNTRY_HIST
(
  CLIENT_ID                           NUMBER(38)                    NULL,
  LIDL_COUNTRY                        VARCHAR(40)                   NULL,
  Z_DS_ZMMX_CONEG_CNTRY_LIFNR         VARCHAR(20)                   NULL,
  Z_DS_ZMMX_CONEG_CNTRY_CONEGOT_COUN  VARCHAR(6)                    NULL,
  SRC_LIFNR                           VARCHAR(40)                   NULL,
  SRC_COUNTRY_LIDL_CD_CONEGOT         VARCHAR(40)                   NULL,
  COUNTRY_CD_CONEGOT                  VARCHAR(20)                   NULL,
  DELETED_FG                          NUMBER(38)                    NULL,
  EXTRACTION_DT                       DATE                          NULL,
  DWH_MAPPING_DT                      DATE                          NULL,
  TF_ERROR_FG                         NUMBER(1,0)                   NULL,
  RECORD_ID                           NUMBER(10,0)                  NULL,
  FILENAME                            VARCHAR(1000)                 NULL
);