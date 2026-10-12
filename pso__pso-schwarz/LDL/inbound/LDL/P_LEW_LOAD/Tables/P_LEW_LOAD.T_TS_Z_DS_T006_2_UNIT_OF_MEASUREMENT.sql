CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_Z_DS_T006_2_UNIT_OF_MEASUREMENT
(
  RECORD_ID           NUMBER(10,0)                  NULL,
  CLIENT_ID           NUMBER(38)                    NULL,
  UOM_SID             NUMBER(38)                    NULL,
  SRC_MSEHI           VARCHAR(20)                   NULL,
  UOM_SID_FAMILY      NUMBER(38)                    NULL,
  UOM_NAME            VARCHAR(100) COLLATE 'en-ci'  NULL,
  UOM_ISO_CD          VARCHAR(20)                   NULL,
  UOM_CD_FAMILY       VARCHAR(20)                   NULL,
  NUMERATOR_CONV_SI   NUMBER(38)                    NULL,
  DENOMINATOR_CONV_SI NUMBER(38)                    NULL,
  DWH_LOAD_ID         NUMBER(38)                    NULL,
  DWH_CREATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED         TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  ERROR_FG            NUMBER(38)                    NULL,
  ERROR_DESCR         VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME            VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO         NUMBER(38)                    NULL
);