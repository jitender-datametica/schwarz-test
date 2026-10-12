CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_V_BW_CABN_2_SAP_ITEM_PROPERTY_IDENTIFIER_2
(
  CLIENT_ID       NUMBER(38)                    NULL,
  IDENTIFIER_ID   NUMBER(38)                    NULL,
  IDENTIFIER_NAME VARCHAR(50) COLLATE 'en-ci'   NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL
);