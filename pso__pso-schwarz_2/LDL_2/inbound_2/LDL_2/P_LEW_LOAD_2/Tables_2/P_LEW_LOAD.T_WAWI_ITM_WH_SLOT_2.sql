CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_WH_SLOT_2
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  WH_ID                 NUMBER(38)                    NOT NULL,
  ITEM_ID               NUMBER(38)                    NOT NULL,
  DAT_REC_START         DATE                          NOT NULL,
  DAT_REC_END           DATE                          NOT NULL,
  WH_SLOT_CASE          NUMBER(38)                    NULL,
  WH_LOCATION_NR_CASE   NUMBER(38)                    NULL,
  WH_SLOT_PALLET        NUMBER(38)                    NULL,
  WH_LOCATION_NR_PALLET NUMBER(38)                    NULL,
  WH_LOCATION_NR_DD     NUMBER(38)                    NULL,
  WH_SLOT_DD            NUMBER(38)                    NULL,
  INV_CASE_FG           NUMBER(38)                    NULL,
  INV_EURO_FG           NUMBER(38)                    NULL,
  INV_DD_FG             NUMBER(38)                    NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL,
  LOAD_TS               TIMESTAMP_NTZ(6)              NULL
);