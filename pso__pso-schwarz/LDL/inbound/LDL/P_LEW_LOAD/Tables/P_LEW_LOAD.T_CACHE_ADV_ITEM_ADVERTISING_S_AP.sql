CREATE TRANSIENT TABLE P_LEW_LOAD.T_CACHE_ADV_ITEM_ADVERTISING_S_AP
(
  CLIENT_ID                   NUMBER(38)                    NOT NULL   COMMENT 'Mandant',
  WH_LOC_SID                  NUMBER(38)                    NOT NULL   COMMENT 'Gesellschafts-Nummer',
  ORIG_ITEM_NR                NUMBER(18,0)                  NOT NULL   COMMENT 'Artikelnummer',
  DAT_ADV                     DATE                          NOT NULL   COMMENT 'Werbetermin',
  DAT_REC_START               DATE                          NOT NULL   COMMENT 'Startdatum technische Gueltigkeit',
  DAT_REC_END                 DATE                          NOT NULL   COMMENT 'Endedatum technische Gueltigkeit',
  DAT_ADV_END                 DATE                                     COMMENT 'Ende Werbetermin',
  DAT_ADV_DESC                VARCHAR(50) COLLATE 'en-ci'              COMMENT 'Beschreibung Werbetermin',
  DAT_BEFORE_SALES            DATE                                     COMMENT 'Datum der Betrachtung Abverkaeufe vor Werbetermin',
  DAT_BEHIND_SALES_PERIOD1    DATE                                     COMMENT 'Datum der Betrachtung Abverkaeufe nach Werbetermin 1',
  DAT_BEHIND_SALES_PERIOD2    DATE                                     COMMENT 'Datum der Betrachtung Abverkaeufe nach Werbetermin 2',
  DAT_BEFORE_DELIVERY         DATE                                     COMMENT 'Datum der Betrachtung Anlieferungen vor Werbetermin',
  DAT_BEHIND_DELIVERY         DATE                                     COMMENT 'Datum der Betrachtung Anlieferungen nach Werbetermin',
  DAT_BEHIND_DELIVERY_PERIOD1 DATE                                     COMMENT 'Datum der Betrachtung Anlieferungen nach Werbetermin 1',
  DAT_BEHIND_DELIVERY_PERIOD2 DATE                                     COMMENT 'Datum der Betrachtung Anlieferungen nach Werbetermin 2',
  DAT_BEHIND_SALES_EXTENSION  DATE                                     COMMENT 'Datum der Betrachtung Verkaufspreis nach Werbetermin',
  ORIG_PROMOTION_DOMAIN_NR    NUMBER(38,0)                             COMMENT 'Fachlicher Schluessel fuer Aktionsbereiche',
  TIMESTAMP_LOAD              TIMESTAMP_NTZ(0)              NOT NULL   COMMENT 'Zeitstempel der Beladung'
);