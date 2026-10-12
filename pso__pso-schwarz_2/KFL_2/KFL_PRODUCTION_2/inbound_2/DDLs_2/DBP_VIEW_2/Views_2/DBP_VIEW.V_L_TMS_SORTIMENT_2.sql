CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_SORTIMENT_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_sortiment_id                         COMMENT 'ID desSortiments. Aus plsortim.srtm_nr'
  ,tms_sortiment_lfd_nr                     COMMENT 'SKey für die Tabelle l_tms_sortiment_2 im Quellsystem. Ausplsortim.srtm_id'
  ,tms_sortiment_bez                        COMMENT 'Bezeichnung zum TMS-Sortiment'
  ,temperaturgruppe_id                      COMMENT 'Temperaturgruppe des Sortiments'
)
COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Waren für verschiedene Sortimente, z. B. Food, O&G, NonFood. Aus der Quelle plsortim (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_sortiment_id,
        tms_sortiment_lfd_nr,
        tms_sortiment_bez,
        temperaturgruppe_id

FROM DBP_DATA.L_TMS_SORTIMENT_2 ;