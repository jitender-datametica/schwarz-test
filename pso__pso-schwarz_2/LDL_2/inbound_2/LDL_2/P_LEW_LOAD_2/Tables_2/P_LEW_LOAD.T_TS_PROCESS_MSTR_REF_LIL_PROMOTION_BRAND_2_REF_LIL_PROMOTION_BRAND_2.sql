CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_PROCESS_MSTR_REF_LIL_PROMOTION_BRAND_2_REF_LIL_PROMOTION_BRAND_2
(
  RECORD_ID             VARCHAR(1000) COLLATE 'en-ci' NULL,
  PROMOTION_BRAND_ID    NUMBER(38)                    NULL,
  PROMOTION_BRAND_DESCR VARCHAR(100) COLLATE 'en-ci'  NULL,
  LIAM1_SRT_CD          NUMBER(38)                    NULL,
  LIFT1_SRT_CD          NUMBER(38)                    NULL,
  ACTIVE_FG             NUMBER(38)                    NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);