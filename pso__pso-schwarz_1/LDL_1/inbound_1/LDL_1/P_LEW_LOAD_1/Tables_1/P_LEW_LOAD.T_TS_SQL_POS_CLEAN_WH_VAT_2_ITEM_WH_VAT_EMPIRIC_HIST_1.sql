CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_SQL_POS_CLEAN_WH_VAT_2_ITEM_WH_VAT_EMPIRIC_HIST_1
(
  RECORD_ID             VARCHAR(1000) COLLATE 'en-ci' NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  LOC_SID_WH            NUMBER(38)                    NULL,
  VAT_EXCEPTION         VARCHAR(300) COLLATE 'en-ci'  NULL,
  ITEM_SID              NUMBER(38)                    NULL,
  VAT_PCT_CALC_TYPE_ID  NUMBER(38)                    NULL,
  VAT_PCT               NUMBER(9,5)                   NULL,
  DELETED_FG            NUMBER(38)                    NULL,
  DWH_VALID_FROM        DATE                          NULL,
  DWH_VALID_TO          DATE                          NULL,
  DWH_LAST_CONFIRM_DT   DATE                          NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);