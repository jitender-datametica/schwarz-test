CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INDICATOR_DAY_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL   COMMENT 'client id',
  ORG_TYPE_ID       NUMBER(38)                    NOT NULL   COMMENT 'unique org type id',
  ORG_UNIT_NR       NUMBER(38)                    NULL       COMMENT 'org unit_1 number for corresponding org type',
  INDICATOR_ID      NUMBER(38)                    NOT NULL   COMMENT 'unique indicator id',
  INDICATOR_TYPE_ID NUMBER(38)                    NOT NULL   COMMENT 'unique indicator type id',
  CY                NUMBER(38)                    NOT NULL   COMMENT 'calendar_1 year',
  DAT_FORMDATE      DATE                          NOT NULL   COMMENT 'day',
  VAL_INDICATOR     NUMBER(18,4)                  NULL       COMMENT 'value of corresponding indicator',
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL   COMMENT 'timestamp load file (last write access; DWHC2)',
  DAT_DAYEND        DATE                          NOT NULL   COMMENT 'dayend date from file',
  LOAD_ID           NUMBER(38)                    NOT NULL   COMMENT 'transformation ID'
);