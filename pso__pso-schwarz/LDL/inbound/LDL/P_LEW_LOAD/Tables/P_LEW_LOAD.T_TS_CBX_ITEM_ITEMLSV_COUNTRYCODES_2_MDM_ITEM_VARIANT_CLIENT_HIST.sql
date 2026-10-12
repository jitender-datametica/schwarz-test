CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_ITEMLSV_COUNTRYCODES_2_MDM_ITEM_VARIANT_CLIENT_HIST
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  MDM_ITEM_VARIANT_SID  NUMBER(38)                    NULL,
  CLIENT_ID_RECIPIENT   NUMBER(38)                    NULL,
  CLIENT_BLOCK_ID       NUMBER(38)                    NULL,
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