CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_PACKINGMETHOD_ASSORTMENT_ASSORTSIZE_2_MDM_ITEM_PACKING_LIST_POS_HIST_2
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  MDM_PACK_LIST_SID       NUMBER(38)                    NULL,
  MDM_ITEM_SET_SID        NUMBER(38)                    NULL,
  MDM_ITEM_SIZE_SID       NUMBER(38)                    NULL,
  PACK_LIST_POS_VERSION   NUMBER(38)                    NULL,
  PACK_LIST_POS_PRIORITY  NUMBER(38)                    NULL,
  PACK_LIST_POS_REQ_QTY   NUMBER(38)                    NULL,
  PACK_LIST_POS_PACK_QTY  NUMBER(38)                    NULL,
  DELETED_FG              NUMBER(38)                    NULL,
  DWH_VALID_FROM          DATE                          NULL,
  DWH_VALID_TO            DATE                          NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);