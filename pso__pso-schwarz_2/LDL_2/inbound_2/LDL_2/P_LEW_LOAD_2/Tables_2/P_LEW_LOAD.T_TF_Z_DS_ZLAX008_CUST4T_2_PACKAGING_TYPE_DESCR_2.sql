CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZLAX008_CUST4T_2_PACKAGING_TYPE_DESCR_2
(
  CLIENT_ID                         NUMBER(38)                    NULL,
  LIDL_COUNTRY                      VARCHAR(40)                   NULL,
  Z_DS_ZLAX008_CUST4T_ZZ_PACK_TYPE  VARCHAR(12)                   NULL,
  Z_DS_ZLAX008_CUST4T_LANGU         VARCHAR(4)                    NULL,
  SRC_ZZ_PACK_TYPE                  VARCHAR(40)                   NULL,
  LANG_CD                           VARCHAR(20)                   NULL,
  PACK_TYPE_DESCR                   VARCHAR(300) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT                     DATE                          NULL,
  DWH_MAPPING_DT                    DATE                          NULL,
  TF_ERROR_FG                       NUMBER(1,0)                   NULL,
  RECORD_ID                         NUMBER(10,0)                  NULL,
  FILENAME                          VARCHAR(1000)                 NULL
);