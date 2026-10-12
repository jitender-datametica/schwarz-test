CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_ZPDX_AGGR31_MIS_2_POS_AGG_VAT
(
  RECORD_ID       NUMBER(10,0)                  NULL,
  CLIENT_ID       NUMBER(38)                    NULL,
  AGGR_NR         NUMBER(38)                    NULL,
  AGGR_REC_NR     NUMBER(38)                    NULL,
  CURR_SID        NUMBER(38)                    NULL,
  TAX_TYPE_CD     VARCHAR(20)                   NULL,
  TAX_VAL         NUMBER(18,5)                  NULL,
  CURR_CD         VARCHAR(20)                   NULL,
  DWH_CAL_DT      DATE                          NULL,
  DWH_LOAD_ID     NUMBER(38)                    NULL,
  DWH_CREATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED     TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  ERROR_FG        NUMBER(38)                    NULL,
  ERROR_DESCR     VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME        VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO     NUMBER(38)                    NULL
);