CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_TOURSTATUS (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_tourstatus_id                        COMMENT 'ID des Tourstatus. Aus plini.entry'
  ,tms_tourstatus_lfd_nr                    COMMENT 'SKey für die Tabelle l_tms_tour_status im Quellsystem. Aus plini.ini_id. Aus plini.ini_id'
  ,tms_tourstatus_bez                       COMMENT 'Bezeichnung zum Tourstatus. (Verladen, Abgerechnet,…)'
)
COMMENT = 'TMS - Referenztabelle zur Kennzeichnung des Status von Touren mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Tourstadien (z. B. an Abrechnung übertragen, abgerechnet, usw). Aus der Quelle plini (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_tourstatus_id,
        tms_tourstatus_lfd_nr,
        tms_tourstatus_bez

FROM DBP_DATA.L_TMS_TOURSTATUS ;