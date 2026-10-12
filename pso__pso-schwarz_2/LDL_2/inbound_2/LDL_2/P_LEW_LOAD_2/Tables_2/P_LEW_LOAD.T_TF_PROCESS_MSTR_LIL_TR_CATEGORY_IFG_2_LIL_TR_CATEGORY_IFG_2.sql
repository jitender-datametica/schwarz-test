CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_PROCESS_MSTR_LIL_TR_CATEGORY_IFG_2_LIL_TR_CATEGORY_IFG_2
(
  CLIENT_ID                                           NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                                        VARCHAR(40)                   NOT NULL,
  PROCESS_MSTR_LIL_TR_CATEGORY_IFG_SRC_SUBITEMGRP_CD  VARCHAR(250)                  NOT NULL,
  PROCESS_MSTR_LIL_TR_CATEGORY_IFG_SRC_FAMILYGRP_CD   VARCHAR(250)                  NOT NULL,
  SRC_SUBITEMGRP_CD                                   VARCHAR(40)                   NOT NULL,
  SRC_FAMILYGRP_CD                                    VARCHAR(40)                   NOT NULL,
  ACTIVE_FG                                           NUMBER(38)                    NULL,
  EXTRACTION_DT                                       DATE                          NULL,
  DWH_MAPPING_DT                                      DATE                          NOT NULL,
  TF_ERROR_FG                                         NUMBER(1,0)                   NULL,
  RECORD_ID                                           VARCHAR(300)                  NOT NULL,
  FILENAME                                            VARCHAR(1000)                 NOT NULL
);