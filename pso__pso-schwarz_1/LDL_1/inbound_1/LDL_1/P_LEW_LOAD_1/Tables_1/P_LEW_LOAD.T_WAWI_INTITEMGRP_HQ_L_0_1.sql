CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INTITEMGRP_HQ_L_0_1
(
  COUNTRY_ISO_CD                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                      VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  SUBITEMGROUP_ID               NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_ID              NUMBER(38)                    NOT NULL,
  SUBITEMGROUP_SHORT_DESC_CTRY  VARCHAR(15) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_DESC_COUNTRY     VARCHAR(35) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_SORTTERM_COUNTRY NUMBER(3,0)                   NULL,
  DAT_DAYEND                    DATE                          NOT NULL,
  LOAD_ID                       NUMBER(38)                    NOT NULL,
  DC_SERVER_ID                  NUMBER(38)                    NOT NULL,
  BIC_ZMLILA                    VARCHAR(20)                   NULL,
  EXTRACTION_TS                 TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID                     NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM                 VARCHAR(20) COLLATE 'en-ci'   NULL
);