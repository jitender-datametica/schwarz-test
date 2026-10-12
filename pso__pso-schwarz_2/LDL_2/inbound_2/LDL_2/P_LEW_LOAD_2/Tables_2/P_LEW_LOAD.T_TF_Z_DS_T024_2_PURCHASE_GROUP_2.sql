CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_Z_DS_T024_2_PURCHASE_GROUP_2
(
  CLIENT_ID       NUMBER(38)                    NULL,
  LIDL_COUNTRY    VARCHAR(40)                   NULL,
  Z_DS_T024_EKGRP VARCHAR(6)                    NULL,
  SRC_EKGRP       VARCHAR(20)                   NULL,
  PUR_GRP_NAME    VARCHAR(100) COLLATE 'en-ci'  NULL,
  EXTRACTION_DT   DATE                          NULL,
  DWH_MAPPING_DT  DATE                          NULL,
  TF_ERROR_FG     NUMBER(1,0)                   NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  FILENAME        VARCHAR(1000)                 NULL
);