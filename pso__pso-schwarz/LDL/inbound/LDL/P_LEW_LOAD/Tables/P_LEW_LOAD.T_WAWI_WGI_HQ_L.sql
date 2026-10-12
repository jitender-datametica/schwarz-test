CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_WGI_HQ_L
(
  COUNTRY_ISO_CD              VARCHAR(3) COLLATE 'en-ci'    NULL,
  WH_ID_HQ                    NUMBER(3,0)                   NULL,
  ITEMGROUP_INT_ID            NUMBER(38)                    NOT NULL,
  ITEMGROUP_INT_NAT_ID        NUMBER(38)                    NOT NULL,
  DAT_VALID_FROM              DATE                          NULL,
  DAT_VALID_UNTIL             DATE                          NULL,
  VERSION                     NUMBER(38)                    NOT NULL,
  ITEMGROUP_INT_DESC_COUNTRY  VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  ITEMGROUP_INT_DESC_GERMAN   VARCHAR(35) COLLATE 'en-ci'   NULL,
  ITEMGROUP_INT_REMARK        VARCHAR(60) COLLATE 'en-ci'   NULL,
  MOD_DATE                    DATE                          NULL,
  DAT_DAYEND                  DATE                          NULL,
  LOAD_ID                     NUMBER(38)                    NULL
);