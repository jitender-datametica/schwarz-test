CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_TCACHE_Z_DS_ZMMX_V_BW_AUSP_2_ITEM_PROPERTY_RELATION_HIST
(
  CLIENT_ID         NUMBER(38,0)                  NULL,
  ITEM_PROPERTY_SID NUMBER(10,0)                  NULL,
  ITEM_SID          NUMBER(20,0)                  NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  DELETED_FG        NUMBER(38)                    NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);