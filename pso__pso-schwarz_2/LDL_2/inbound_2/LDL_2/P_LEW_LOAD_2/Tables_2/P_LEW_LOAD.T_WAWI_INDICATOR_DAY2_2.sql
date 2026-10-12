CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INDICATOR_DAY2_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL   COMMENT 'client id',
  ORG_UNIT_NR       NUMBER(38)                    NULL       COMMENT 'org unit_2 number for corresponding org type',
  INDICATOR_ID      NUMBER(38)                    NOT NULL   COMMENT 'unique indicator id',
  INDICATOR_TYPE_ID NUMBER(38)                    NOT NULL   COMMENT 'unique indicator type id',
  DAT_FORMDATE      DATE                          NOT NULL   COMMENT 'day',
  ORG_TYPE_ID       NUMBER(38)                    NOT NULL   COMMENT 'unique org type id',
  CY                NUMBER(38)                    NOT NULL   COMMENT 'calendar_2 year'
);