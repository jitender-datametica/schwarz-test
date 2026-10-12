CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0INFO_REC_ATTR_2_PINFO_HEADER_1
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  PINFO_SID       NUMBER(38)                    NULL,
  SRC_INFNR       VARCHAR(20)                   NULL,
  SUP_SID         NUMBER(38)                    NULL,
  ITEM_SID        NUMBER(38)                    NULL,
  SAP_CREATION_DT DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);