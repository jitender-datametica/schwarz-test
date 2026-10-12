CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INDICATOR_DELETE_L_2
(
  INDICATOR_ID        NUMBER(38)                    NOT NULL,
  INDICATOR_TYPE_ID   NUMBER(38)                    NOT NULL,
  ORG_TYPE_ID         NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD      VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  ORG_UNIT_NR         NUMBER(38)                    NULL,
  CY                  NUMBER(38)                    NULL,
  DAT_FORMDATE_FROM   DATE                          NULL,
  DAT_FORMDATE_UNTIL  DATE                          NULL,
  CAL_WEEK_FROM       NUMBER(38)                    NULL,
  CAL_WEEK_UNTIL      NUMBER(38)                    NULL,
  MONTH_ID_FROM       NUMBER(38)                    NULL,
  MONTH_ID_UNTIL      NUMBER(38)                    NULL,
  FILE_NAME           VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN        TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND          DATE                          NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);