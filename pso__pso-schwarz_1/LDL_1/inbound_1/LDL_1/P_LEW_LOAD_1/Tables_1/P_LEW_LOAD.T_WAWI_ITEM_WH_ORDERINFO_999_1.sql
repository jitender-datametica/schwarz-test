CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_WH_ORDERINFO_999_1
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  WH_LOC_SID            NUMBER(38)                    NOT NULL,
  ITEM_SID              NUMBER(38)                    NOT NULL,
  DAT_REC_END           DATE                          NOT NULL,
  DAT_REC_START         DATE                          NOT NULL,
  DISPO_UNIT_ID         NUMBER(38)                    NULL,
  DISPO_GROUP_ID        NUMBER(38)                    NULL,
  WEIGHT                NUMBER(18,4)                  NULL,
  WEIGHT_FG             NUMBER(38)                    NULL,
  DELIVERY_TIME         NUMBER(38)                    NULL,
  MIN_ORDER_WEEK        NUMBER(38)                    NULL,
  ORDER_ITEM_FG         NUMBER(38)                    NULL,
  DISPO_CD              VARCHAR(7) COLLATE 'en-ci'    NULL,
  DISPO_PERIOD          NUMBER(38)                    NULL,
  DISPO_ADD_INFORMATION VARCHAR(20) COLLATE 'en-ci'   NULL,
  BEST_BEFORE_FG        NUMBER(38)                    NULL,
  PALLET_NOTE           NUMBER(38)                    NULL,
  AUTOMATIC_ORDER_FG    NUMBER(38)                    NULL,
  DIRECT_DELIVERY_FG    NUMBER(38)                    NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);