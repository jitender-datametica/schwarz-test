CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_ITEMQUANTITY_DELIVERY_2_MDM_ITEM_CLIENT_ORDER_DELIVERY_HIST_2
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  MDM_ITEM_SID          NUMBER(38)                    NULL,
  CLIENT_ID_ORDER       NUMBER(38)                    NULL,
  COUNTRY_DEL_SEQ_NR    NUMBER(38)                    NULL,
  CY_WEEK_DELIVERY      NUMBER(38)                    NULL,
  COUNTRY_REQUEST_QTY   NUMBER(38)                    NULL,
  COUNTRY_DELIVERY_QTY  NUMBER(38)                    NULL,
  DELETED_FG            NUMBER(38)                    NULL,
  DWH_VALID_FROM        DATE                          NULL,
  DWH_VALID_TO          DATE                          NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);