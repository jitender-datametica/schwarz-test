CREATE TABLE P_LEW_MART_LEAD.T_AGG_SHELF_CAPACITY_FAM_STORE_DAY_1 CLUSTER BY (client_id, dat_formdate) COMMENT = 'Aggregierte Restantenquoten - Schlüssel: client_id/store_id/dat_formdate/artikel_1 familie'
(
  client_id                   NUMBER(38,0)    NOT NULL        COMMENT 'MIS Client ID'
, loc_sid_store               NUMBER(38,0)    NOT NULL        COMMENT 'S-Key der Location_1, hier der Filiale'
, dat_formdate                DATE            NOT NULL        COMMENT 'Bezugsdatum'
, cy_week                     NUMBER(38,0)    NOT NULL        COMMENT 'Geschäftsjahr - Woche_1 Id - Format "JJJJMM"'
, cy_week_partial_week_id     NUMBER(38,0)    NOT NULL        COMMENT 'Teilwoche: Format yyyywwn, n in (1,2,9)'
, cy_month                    NUMBER(38,0)    NOT NULL        COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'
, busyear                     NUMBER(38,0)    NOT NULL        COMMENT 'Geschäftsjahr'
, currency_iso_cd             VARCHAR(3)      COLLATE 'en-ci' COMMENT '3 stelliger ISO-Währungs-Code'
, curr_tot_id                 NUMBER(38,0)    NOT NULL        COMMENT 'Interner Währungs-Code'
, item_familygroup_id         NUMBER(38,0)    NOT NULL        COMMENT 'Artikelfamilie ID'
, restantenquote_fil_pct      DECIMAL(38,5)                   COMMENT 'Durchschnitt aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY_1 restantenquote_fil'
, regelfuellmenge_0_cnt       NUMBER(38,0)                    COMMENT 'Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY_1 regelfuellmenge_0'
, skipped_cnt                 NUMBER(38,0)                    COMMENT 'Summe aus P_LEW_MART_LEAD.T_SHELF_CAPACITY_ITEM_STORE_DAY_1 skipped_fg'
, dwh_updated                 TIMESTAMP                       COMMENT 'Technische Zeitstempel'
)
;