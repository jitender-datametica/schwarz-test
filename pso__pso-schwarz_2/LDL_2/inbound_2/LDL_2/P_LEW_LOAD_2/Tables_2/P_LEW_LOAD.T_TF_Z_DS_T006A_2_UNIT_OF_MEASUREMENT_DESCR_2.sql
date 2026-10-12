CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_T006A_2_UNIT_OF_MEASUREMENT_DESCR_2
(
  CLIENT_ID         NUMBER(38)                    NULL,
  LIDL_COUNTRY      VARCHAR(40)                   NULL,
  Z_DS_T006A_SPRAS  VARCHAR(2)                    NULL,
  Z_DS_T006A_MSEHI  VARCHAR(6)                    NULL,
  SRC_MSEHI         VARCHAR(40)                   NULL,
  SRC_SPRAS         VARCHAR(40)                   NULL,
  UOM_CD            VARCHAR(20)                   NULL,
  LANG_CD           VARCHAR(20)                   NULL,
  UOM_DESCR_SHORT   VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_DESCR_LONG    VARCHAR(300) COLLATE 'en-ci'  NULL,
  UOM_DESCR_EXT_3CH VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_DESCR_EXT_6CH VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT     DATE                          NULL,
  DWH_MAPPING_DT    DATE                          NULL,
  TF_ERROR_FG       NUMBER(1,0)                   NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  FILENAME          VARCHAR(1000)                 NULL
);