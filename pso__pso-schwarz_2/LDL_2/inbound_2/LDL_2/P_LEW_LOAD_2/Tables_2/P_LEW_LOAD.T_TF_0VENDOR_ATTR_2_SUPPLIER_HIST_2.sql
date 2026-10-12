CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_0VENDOR_ATTR_2_SUPPLIER_HIST_2
(
  CLIENT_ID                 NUMBER(38)                    NULL,
  LIDL_COUNTRY              VARCHAR(40)                   NULL,
  VENDOR_ATTR_LIFNR         VARCHAR(20)                   NULL,
  SRC_LIFNR                 VARCHAR(40)                   NULL,
  SRC_WERKS                 VARCHAR(40)                   NULL,
  SRC_LAND1_NEGOT           VARCHAR(40)                   NULL,
  SRC_ADDRNUMBER            VARCHAR(40)                   NULL,
  COUNTRY_CD_NEGOT          VARCHAR(20)                   NULL,
  DEBTOR_CD                 VARCHAR(20)                   NULL,
  NAME_1                    VARCHAR(100) COLLATE 'en-ci'  NULL,
  INT_LOCATION_NO_1         NUMBER(38)                    NULL,
  INT_LOCATION_NO_2         NUMBER(38)                    NULL,
  INT_LOCATION_CHECKING_NO  NUMBER(38)                    NULL,
  DELETED_FG                NUMBER(38)                    NULL,
  EXTRACTION_DT             DATE                          NULL,
  DWH_MAPPING_DT            DATE                          NULL,
  TF_ERROR_FG               NUMBER(1,0)                   NULL,
  RECORD_ID                 NUMBER(10,0)                  NULL,
  FILENAME                  VARCHAR(1000)                 NULL
);