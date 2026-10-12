CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_GUARANTEETYPE_2_REF_MDM_GUARANTEE_TYPE
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  GUARANTEE_TYPE_CD     VARCHAR(100) COLLATE 'en-ci'  NULL,
  GUARANTEE_TYPE_DESCR  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);