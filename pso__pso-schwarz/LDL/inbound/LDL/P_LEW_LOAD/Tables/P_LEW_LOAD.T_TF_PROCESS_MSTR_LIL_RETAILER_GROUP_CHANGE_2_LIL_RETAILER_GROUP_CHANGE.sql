CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_RETAILER_GROUP_CHANGE_2_LIL_RETAILER_GROUP_CHANGE
(
  RETAILER_GROUP_CHANGE_ID  NUMBER(38)                    NOT NULL,
  SRC_RETAILER_GRP_CD       VARCHAR(100)                  NULL,
  SRC_RETAILER_CHLD_CD      VARCHAR(100)                  NULL,
  SRC_RETAILER_CHG_CD       VARCHAR(100)                  NULL,
  ACTIVE_FG                 NUMBER(38)                    NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NOT NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 VARCHAR(300)                  NOT NULL,
  FILENAME                  VARCHAR(1000)                 NOT NULL
);