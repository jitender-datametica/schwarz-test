CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_PROCESS_MSTR_LIL_RETAILER_GROUP_CHANGE_2_LIL_RETAILER_GROUP_CHANGE_1
(
  RECORD_ID                 VARCHAR(1000) COLLATE 'en-ci' NULL,
  RETAILER_GROUP_CHANGE_ID  NUMBER(38)                    NULL,
  SRC_RETAILER_GRP_CD       VARCHAR(100)                  NULL,
  SRC_RETAILER_CHLD_CD      VARCHAR(100)                  NULL,
  SRC_RETAILER_CHG_CD       VARCHAR(100)                  NULL,
  ACTIVE_FG                 NUMBER(38)                    NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);