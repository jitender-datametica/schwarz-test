CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMGRP_HQ_C_1
(
  ERR_ID                          NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE                     NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER                    VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                        DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                          NUMBER(38)                    NULL,
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
  LOAD_ID                         NUMBER(38)                    NULL
)
;