CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_T006_2_UNIT_OF_MEASUREMENT
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  Z_DS_T006_MSEHI     VARCHAR(6)                    NULL,
  SRC_MSEHI           VARCHAR(20)                   NULL,
  SRC_MSEHI_FAMILY    VARCHAR(40)                   NULL,
  UOM_NAME            VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_ISO_CD          VARCHAR(20)                   NULL,
  UOM_CD_FAMILY       VARCHAR(20)                   NULL,
  NUMERATOR_CONV_SI   NUMBER(38)                    NULL,
  DENOMINATOR_CONV_SI NUMBER(38)                    NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);