CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_TCURR_2_CACHE_Z_DS_TCURR_HIST_1
(
  CLIENT_ID         NUMBER(38,0)                  NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_TCURR_KURST  VARCHAR(8)                    NULL,
  Z_DS_TCURR_FCURR  VARCHAR(10)                   NULL,
  Z_DS_TCURR_TCURR  VARCHAR(10)                   NULL,
  Z_DS_TCURR_GDATU  VARCHAR(16)                   NULL,
  BIC_ZMLILA        VARCHAR(60)                   NULL,
  FCURR             VARCHAR(60)                   NULL,
  TCURR             VARCHAR(60)                   NULL,
  KURST             VARCHAR(60)                   NULL,
  GDATU             DATE                          NULL,
  UKURS             NUMBER(18,5)                  NULL,
  ACTIVE_FROM_DT    DATE                          NULL,
  DELETED_FG        NUMBER(38,0)                  NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);