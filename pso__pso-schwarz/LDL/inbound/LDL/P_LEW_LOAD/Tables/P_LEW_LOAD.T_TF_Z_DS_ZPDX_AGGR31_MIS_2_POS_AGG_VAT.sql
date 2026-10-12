CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZPDX_AGGR31_MIS_2_POS_AGG_VAT
(
  CLIENT_ID                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                      VARCHAR(40)                   NULL,
  Z_DS_ZPDX_AGGR31_MIS_AGGR_NO      VARCHAR(11)                   NULL,
  Z_DS_ZPDX_AGGR31_MIS_REC_ID       VARCHAR(11)                   NULL,
  Z_DS_ZPDX_AGGR31_MIS_TAXTYPECODE  VARCHAR(4)                    NULL,
  AGGR_NR                           NUMBER(38)                    NULL,
  AGGR_REC_NR                       NUMBER(38)                    NULL,
  SRC_WAERS                         VARCHAR(40)                   NULL,
  TAX_TYPE_CD                       VARCHAR(20)                   NULL,
  TAX_VAL                           NUMBER(18,5)                  NULL,
  CURR_CD                           VARCHAR(20)                   NULL,
  DWH_CAL_DT                        DATE                          NULL,
  EXTRACTION_DT                     DATE                          NULL,
  DWH_MAPPING_DT                    DATE                          NULL,
  TF_ERROR_FG                       NUMBER(1,0)                   NULL,
  RECORD_ID                         NUMBER(10,0)                  NULL,
  FILENAME                          VARCHAR(1000)                 NULL
);