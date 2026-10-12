CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INTITEMGRP_HQ_C
(
  ERR_ID                        NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE                   NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER                  VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                      DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                        NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                      VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  SUBITEMGROUP_ID               NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_ID              NUMBER(38)                    NOT NULL,
  SUBITEMGROUP_SHORT_DESC_CTRY  VARCHAR(15) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_DESC_COUNTRY     VARCHAR(35) COLLATE 'en-ci'   NULL,
  SUBITEMGROUP_SORTTERM_COUNTRY NUMBER(3,0)                   NULL,
  DAT_DAYEND                    DATE                          NOT NULL,
  LOAD_ID                       NUMBER(38)                    NOT NULL
)
;