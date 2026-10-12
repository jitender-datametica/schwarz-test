CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZLEX_V_BW_EINE_2_PINFO_DETAIL_HIST_2
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  Z_DS_ZLEX_V_BW_EINE_INFNR VARCHAR(20)                   NULL,
  Z_DS_ZLEX_V_BW_EINE_EKORG VARCHAR(8)                    NULL,
  Z_DS_ZLEX_V_BW_EINE_ESOKZ VARCHAR(2)                    NULL,
  Z_DS_ZLEX_V_BW_EINE_WERKS VARCHAR(8)                    NULL,
  SRC_INFNR                 VARCHAR(40)                   NULL,
  SRC_WERKS                 VARCHAR(40)                   NULL,
  SRC_EKORG                 VARCHAR(40)                   NULL,
  SRC_BRAND_CD              VARCHAR(40)                   NULL,
  PINFO_TYPE_CD             VARCHAR(20)                   NULL,
  INCOTERM_1                VARCHAR(20)                   NULL,
  INCOTERM_2                VARCHAR(100) COLLATE 'en-ci'  NULL,
  DELETED_FG                NUMBER(38)                    NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);