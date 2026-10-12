CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZPDX_AGGR1A_MIS_2_POS_AGG_BON_CNTS_1
(
  CLIENT_ID                             NUMBER(38)                    NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NULL,
  Z_DS_ZPDX_AGGR1A_MIS_RETAILSTOREID    VARCHAR(10)                   NULL,
  Z_DS_ZPDX_AGGR1A_MIS_BUSINESSDAYDATE  DATE                          NULL,
  Z_DS_ZPDX_AGGR1A_MIS_AGGR_NO          VARCHAR(11)                   NULL,
  SRC_WERKS                             VARCHAR(40)                   NULL,
  AGGR_NR                               NUMBER(38)                    NULL,
  CNT_RECEIPTS_SALES                    NUMBER(38)                    NULL,
  CNT_RECEIPTS_RETURNS                  NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_TOTAL                NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_SALES                NUMBER(38)                    NULL,
  CNT_RECEIPTLINES_RETURNS              NUMBER(38)                    NULL,
  TRANS_START_TMSP                      TIMESTAMP_NTZ(6)              NULL,
  TRANS_END_TMSP                        TIMESTAMP_NTZ(6)              NULL,
  DWH_CAL_DT                            DATE                          NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             NUMBER(10,0)                  NULL,
  FILENAME                              VARCHAR(1000)                 NULL
);