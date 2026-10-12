CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_STANDORTTYP (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_standorttyp_id                       COMMENT 'ID des Standorttyps. Aus plini.entry'
  ,tms_standorttyp_lfd_nr                   COMMENT 'SKey für die Tabelle l_tms_standort_typ im Quellsystem. Aus plini.ini_id'
  ,tms_standorttyp_bez                      COMMENT 'Bezeichnung zum Standorttyp (z. B. Frühmarkt, Lieferant, EWM Lager, usw)'
)
COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Standorten für verschiedene Standorttypen (z. B. Frühmarkt, Lieferant, EWM Lager, usw). Aus der Quelle plini (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_standorttyp_id,
        tms_standorttyp_lfd_nr,
        tms_standorttyp_bez

FROM DBP_DATA.L_TMS_STANDORTTYP ;