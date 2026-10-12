CREATE TABLE P_LEW_MART_LEAD.T_AGG_SHELF_CAPACITY_WGI_STORE_DAY CLUSTER BY (client_id, dat_formdate) COMMENT = 'Aggregierte Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/wgi'
(
  client_id                   NUMBER(38,0)    NOT NULL         COMMENT 'MIS Client ID'
, loc_sid_store               NUMBER(38,0)    NOT NULL         COMMENT 'S-Key der Location, hier der Filiale'
, dat_formdate                DATE            NOT NULL         COMMENT 'Bezugsdatum'
, cy_week                     NUMBER(38,0)    NOT NULL         COMMENT 'Geschäftsjahr - Woche Id - Format "JJJJMM"'
, cy_week_partial_week_id     NUMBER(38,0)    NOT NULL         COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                    NUMBER(38,0)    NOT NULL         COMMENT 'Monat des Geschäftsjahres im Format "JJJJMM"'
, busyear                     NUMBER(38,0)    NOT NULL         COMMENT 'Geschäftsjahr'
, currency_iso_cd             VARCHAR(3)      COLLATE 'en-ci'  COMMENT '3 stelliger ISO-Währungs-Code'
, curr_tot_id                 NUMBER(38,0)    NOT NULL         COMMENT 'Interner Währungs-Code'
, itemgroup_int_id            NUMBER(38,0)    NOT NULL         COMMENT 'Warengruppe ID'
, restantenquote_fil_pct      DECIMAL(38,5)                    COMMENT 'Durchschnitt aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY restantenquote_fil'
, regelfuellmenge_0_cnt       NUMBER(38,0)                     COMMENT 'Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY regelfuellmenge_0'
, skipped_cnt                 NUMBER(38,0)                     COMMENT 'Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY skipped_fg'
, dwh_updated                 TIMESTAMP                        COMMENT 'Technische Zeitstempel'
)
;