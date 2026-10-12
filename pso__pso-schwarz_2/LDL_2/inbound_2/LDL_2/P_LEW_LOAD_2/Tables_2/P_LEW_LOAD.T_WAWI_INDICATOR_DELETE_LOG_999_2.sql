CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INDICATOR_DELETE_LOG_999_2
(
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  ORG_TYPE_ID         NUMBER(38)                    NOT NULL,
  ORG_UNIT_NR         NUMBER(38)                    NULL,
  INDICATOR_ID        NUMBER(38)                    NOT NULL,
  INDICATOR_TYPE_ID   NUMBER(38)                    NOT NULL,
  CY                  NUMBER(38)                    NULL,
  DAT_FORMDATE_FROM   DATE                          NULL,
  DAT_FORMDATE_UNTIL  DATE                          NULL,
  CAL_WEEK_FROM       NUMBER(38)                    NULL,
  CAL_WEEK_UNTIL      NUMBER(38)                    NULL,
  MONTH_ID_FROM       NUMBER(38)                    NULL,
  MONTH_ID_UNTIL      NUMBER(38)                    NULL,
  TIMESTAMP_FN        TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND          DATE                          NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);