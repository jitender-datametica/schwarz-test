CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMGRP_HQ_L_0
(
  COUNTRY_ISO_CD                  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  SUBITEMGROUP_ID                 NUMBER(38)                    NOT NULL,
  PERSON_ID                       NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_ID                NUMBER(38)                    NOT NULL,
  PERSON_NAME                     VARCHAR(28) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_SHORT_DESC_GERMAN  VARCHAR(15) COLLATE 'en-ci'   NOT NULL,
  SUBITEMGROUP_DESC_GERMAN        VARCHAR(35) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_SORTTERM_GERMAN    NUMBER(3,0)                   NOT NULL,
  DIFF_RCV                        NUMBER(2,0)                   NULL,
  STATISTICGROUP_ID               NUMBER(38)                    NULL,
  CNT_RCV                         NUMBER(38)                    NULL,
  RCV_DAYS                        NUMBER(38)                    NULL,
  ITEMGROUP_INT_ID                NUMBER(38)                    NOT NULL,
  DAT_DAYEND                      DATE                          NULL,
  LOAD_ID                         NUMBER(38)                    NULL,
  DC_SERVER_ID                    NUMBER(38)                    NOT NULL,
  BIC_ZMLILA                      VARCHAR(20)                   NULL,
  EXTRACTION_TS                   TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID                       NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM                   VARCHAR(20) COLLATE 'en-ci'   NULL
);