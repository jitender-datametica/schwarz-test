CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ACTIONGROUP_HQ_L_1
(
  COUNTRY_ISO_CD                  VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_VALID_FROM                  DATE                          NOT NULL,
  DAT_VALID_UNTIL                 DATE                          NOT NULL,
  ITEM_SUB_ACTGROUP_DESC_COUNTRY  VARCHAR(50) COLLATE 'en-ci'   NULL,
  ITEM_SUB_ACTGROUP_DESC_GERMAN   VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  ITEM_SUB_ACTIONGROUP_ID         NUMBER(38)                    NOT NULL,
  ITEM_ACTGROUP_DESC_COUNTRY      VARCHAR(50) COLLATE 'en-ci'   NULL,
  ITEM_ACTGROUP_DESC_GERMAN       VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  ITEM_ACTIONGROUP_ID             NUMBER(38)                    NOT NULL,
  DAT_DAYEND                      DATE                          NULL,
  LOAD_ID                         NUMBER(38)                    NULL
);