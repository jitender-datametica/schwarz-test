CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0INFO_REC_ATTR_2_PINFO_HEADER_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  INFO_REC_ATTR_INFNR VARCHAR(20)                   NULL,
  SRC_INFNR           VARCHAR(20)                   NULL,
  SRC_LIFNR           VARCHAR(40)                   NULL,
  SRC_MATNR           VARCHAR(40)                   NULL,
  SAP_CREATION_DT     DATE                          NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);