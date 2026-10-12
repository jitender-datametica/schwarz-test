CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_DISPO_ORDERHEAD_WH_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  WH_ID             NUMBER(38)                    NOT NULL,
  PO_NR             VARCHAR(12) COLLATE 'en-ci'   NOT NULL,
  SUPPLIER_ID       NUMBER(38)                    NOT NULL,
  DAT_DELIVERY      DATE                          NOT NULL,
  DISPO_LFD_NR      VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  STATUS_DISPO      NUMBER(38)                    NULL,
  DAT_DISPO_CREATE  TIMESTAMP_NTZ(0)              NULL,
  DAT_DISPO_MODIFY  TIMESTAMP_NTZ(0)              NULL,
  BATCH_ID_DISPO    NUMBER(38)                    NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND        DATE                          NULL,
  LOAD_ID           NUMBER(38)                    NULL
);