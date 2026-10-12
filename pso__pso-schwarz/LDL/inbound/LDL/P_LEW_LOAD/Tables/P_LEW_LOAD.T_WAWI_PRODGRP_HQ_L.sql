CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PRODGRP_HQ_L
(
  COUNTRY_ISO_CD                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                      NUMBER(3,0)                   NOT NULL,
  MAINITEMGROUP_ID              NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_SHORT_DESC_GER  VARCHAR(15) COLLATE 'en-ci'   NULL,
  MAINITEMGROUP_DESC_GERMAN     VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  SORTING_TERM                  NUMBER(3,0)                   NOT NULL,
  DAT_DAYEND                    DATE                          NULL,
  LOAD_ID                       NUMBER(38)                    NULL
);