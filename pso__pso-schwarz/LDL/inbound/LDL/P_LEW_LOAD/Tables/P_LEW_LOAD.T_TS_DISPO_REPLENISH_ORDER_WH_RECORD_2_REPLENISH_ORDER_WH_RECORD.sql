CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_DISPO_REPLENISH_ORDER_WH_RECORD_2_REPLENISH_ORDER_WH_RECORD
(
  RECORD_ID           VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  LOC_SID             NUMBER(38)                    NULL,
  ORDER_RECORD_ID     VARCHAR(20) COLLATE 'en-ci'   NULL,
  ORDER_SEQ_NR        NUMBER(38)                    NULL,
  ORDER_CREATED_TMSP  TIMESTAMP_NTZ(0)              NULL,
  ORDER_UPDATED_TMSP  TIMESTAMP_NTZ(0)              NULL,
  ORDER_STATUS_CD     NUMBER(38)                    NULL,
  ORDER_BATCH_ID      NUMBER(38)                    NULL,
  SUP_SID             NUMBER(38)                    NULL,
  DELIVERY_DT         DATE                          NULL,
  DWH_CAL_DT          DATE                          NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);