CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_ITM_MISSING_2_ITEM_MISSING
(
  CLIENT_ID                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NULL,
  ITM_MISSING__SLASH_BIC_SLASH_ZMMI_NO  VARCHAR(20)                   NULL,
  ITEM_MISSING_ID                       NUMBER(20,0)                  NULL,
  SRC_MATNR                             VARCHAR(40)                   NULL,
  SRC_WERKS                             VARCHAR(40)                   NULL,
  STORAGE_LOC_CD                        VARCHAR(20)                   NULL,
  DWH_CAL_DT                            DATE                          NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             NUMBER(10,0)                  NULL,
  FILENAME                              VARCHAR(1000)                 NULL
);