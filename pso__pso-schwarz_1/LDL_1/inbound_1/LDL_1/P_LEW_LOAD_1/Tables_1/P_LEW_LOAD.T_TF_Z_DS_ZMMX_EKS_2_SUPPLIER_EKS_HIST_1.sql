CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_ZMMX_EKS_2_SUPPLIER_EKS_HIST_1
(
  CLIENT_ID           NUMBER(38)                    NULL,
  LIDL_COUNTRY        VARCHAR(40)                   NULL,
  Z_DS_ZMMX_EKS_EKSNR NUMBER(5,0)                   NULL,
  Z_DS_ZMMX_EKS_LIFNR VARCHAR(20)                   NULL,
  SRC_LIFNR           VARCHAR(40)                   NULL,
  EKS_NO              NUMBER(38)                    NULL,
  DELETED_FG          NUMBER(38)                    NULL,
  EXTRACTION_DT       DATE                          NULL,
  DWH_MAPPING_DT      DATE                          NULL,
  TF_ERROR_FG         NUMBER(1,0)                   NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  FILENAME            VARCHAR(1000)                 NULL
);