CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_CUST14T_2_REF_RETURN_REASON_DESCR_2
(
  CLIENT_ID                       NUMBER(38)                    NULL,
  LIDL_COUNTRY                    VARCHAR(40)                   NULL,
  Z_DS_ZMMX_CUST14T_RET_REASON_K  VARCHAR(8)                    NULL,
  Z_DS_ZMMX_CUST14T_SPRAS         VARCHAR(4)                    NULL,
  RETURN_REASON_CD                VARCHAR(20)                   NULL,
  LANG_CD                         VARCHAR(20)                   NULL,
  RETURN_REASON_DESCR             VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                   DATE                          NULL,
  DWH_MAPPING_DT                  DATE                          NULL,
  TF_ERROR_FG                     NUMBER(1,0)                   NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  FILENAME                        VARCHAR(1000)                 NULL
);