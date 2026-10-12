CREATE TRANSIENT TABLE P_LEW_LOAD.T_TCACHE_MMO_SHELF_CAPACITY_ITEM_LOCATION_REPLENISHMENT_INFO_HIST
(
  CLIENT_ID               NUMBER(38)                    NULL,
  LOC_SID                 NUMBER(38)                    NOT NULL,
  ITEM_SID                NUMBER(38)                    NOT NULL,
  LOC_SID_WH              NUMBER(38)                    NULL,
  SHELF_CAPACITY_UNIT_ID  NUMBER(38)                    NULL,
  SHELF_CAPACITY_QTY      NUMBER(38)                    NULL,
  EXTRACTION_DATE         DATE                          NOT NULL,
  DWH_LOAD_ID             NUMBER(38)                    NOT NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NOT NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NOT NULL
);