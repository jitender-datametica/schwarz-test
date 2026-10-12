CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_TCACHE_Z_DS_ZMMX_V_BW_CAWN_2_ITEM_PROPERTY_1
(
  CLIENT_ID             NUMBER(38)                    NULL,
  SRC_ATWRT             VARCHAR(50) COLLATE 'en-ci'   NULL,
  ITEM_PROPERTY_CD      VARCHAR(100) COLLATE 'en-ci'  NULL,
  SRC_ITEM_PROPERTY_ID  NUMBER(38)                    NULL,
  EXTRACTION_DT         DATE                          NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  TF_ERROR_FG           NUMBER(1,0)                   NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL
);