CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_2LIS_02_SCL_2_ORDER_RECORD_POS_2
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  ORDER_RECORD_ID     NUMBER(20,0)                  NULL,
  ORDER_RECORD_POS_ID NUMBER(38)                    NULL,
  LOC_SID             NUMBER(38)                    NULL,
  ITEM_SID            NUMBER(38)                    NULL,
  UOM_SID             NUMBER(38)                    NULL,
  UOM_CD              VARCHAR(20)                   NULL,
  RETURN_REASON_MARK  VARCHAR(20)                   NULL,
  RETURN_REASON_LABEL VARCHAR(100) COLLATE 'en-ci'  NULL,
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