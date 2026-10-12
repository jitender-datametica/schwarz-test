CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_CBX_ITEM_SHIPPINGTERMS_2_MDM_SHIP_TERMS_2
(
  RECORD_ID               NUMBER(10,0)                  NULL,
  CLIENT_ID               NUMBER(38)                    NULL,
  SHIP_TERMS_SID          NUMBER(38)                    NULL,
  SRC_COMPLETION_TYPE_CD  VARCHAR(20) COLLATE 'en-ci'   NULL,
  SRC_INCOTERMS_CD        VARCHAR(20) COLLATE 'en-ci'   NULL,
  CURR_SID_INVOICE        NUMBER(38)                    NULL,
  CURR_CD_INVOICE         VARCHAR(20) COLLATE 'en-ci'   NULL,
  SHIP_TO                 VARCHAR(100) COLLATE 'en-ci'  NULL,
  SHIP_TERMS              VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID             NUMBER(38)                    NULL,
  DWH_CREATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED             TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT          DATE                          NULL,
  ERROR_FG                NUMBER(38)                    NULL,
  ERROR_DESCR             VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO             NUMBER(38)                    NULL
);