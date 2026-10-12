CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_AUFTRAGSART (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_auftragsart_id                       COMMENT 'ID der Auftragsart. Aus plini.entry'
  ,tms_auftragsart_lfd_nr                   COMMENT 'SKey für die Tabelle l_tms_auftragsart im Quellsystem. Aus plini.ini_id'
  ,tms_auftragsart_bez                      COMMENT 'Bezeichnung zur Auftragsart'
)
COMMENT = 'TMS - Referenztabelle zur Klassifizierung von TMS Aufträgen mit eindeutigen Bezeichnungen und Beschreibungen für verschiedene Auftragsarten. Aus der Quelle plini (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_auftragsart_id,
        tms_auftragsart_lfd_nr,
        tms_auftragsart_bez

FROM DBP_DATA.L_TMS_AUFTRAGSART ;