CREATE TRANSIENT TABLE P_LEW_LOAD.T_DAY_CNT_STR_WEEK_STR_WGI_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  MOVE_TO_STORE_ID  NUMBER(38)                    NOT NULL,
  DAT_FORMDATE      DATE                          NOT NULL,
  ASPECT_ID         NUMBER(38)                    NULL,
  CURRENCY_ISO_CD   VARCHAR(3) COLLATE 'en-ci'    NULL,
  ITEMGROUP_INT_ID  NUMBER(38)                    NULL,
  CNT_DAY_STORE     NUMBER(18,4)                  NULL,
  LOAD_TS           TIMESTAMP_NTZ(0)              NULL
);