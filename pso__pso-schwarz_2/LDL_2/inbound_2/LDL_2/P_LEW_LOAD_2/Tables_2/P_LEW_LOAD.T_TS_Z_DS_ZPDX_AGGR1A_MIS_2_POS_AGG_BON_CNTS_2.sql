CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZPDX_AGGR1A_MIS_2_POS_AGG_BON_CNTS_2
(
  RECORD_ID                 NUMBER(10,0)                  NULL,
  CLIENT_ID                 NUMBER(38)                    NULL,
  LOC_SID                   NUMBER(38)                    NULL,
  AGGR_NR                   NUMBER(38)                    NULL,
  CNT_RECEIPTS_SALES        NUMBER(38)                    NULL,
  CNT_RECEIPTS_RETURNS      NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_TOTAL    NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_SALES    NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_RETURNS  NUMBER(38)                    NULL,
  TRANS_START_TMSP          TIMESTAMP_NTZ(6)              NULL,
  TRANS_END_TMSP            TIMESTAMP_NTZ(6)              NULL,
  DWH_CAL_DT                DATE                          NULL,
  DWH_LOAD_ID               NUMBER(38)                    NULL,
  DWH_CREATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED               TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  ERROR_FG                  NUMBER(38)                    NULL,
  ERROR_DESCR               VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME                  VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO               NUMBER(38)                    NULL
);