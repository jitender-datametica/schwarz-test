CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_TOURTYP (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_tourtyp_id                           COMMENT 'ID des Tourtyps. Aus plini.entry'
  ,tms_tourtyp_lfd_nr                       COMMENT 'SKey für die Tabelle l_tms_tourtyp im Quellsystem. Aus plini.ini_id'
  ,tms_tourtyp_bez                          COMMENT 'Bezeichnung zum Tourtyp. z. B. 105 = "01 - Zutour - keine Abrechnung", 106 = "03 - Internationaler Transport", 201 = "02 - Abholung Lieferant", ...'
)
COMMENT = 'TMS - Referenztabelle zur Klassifizierung von Touren für verschiedene Tourtypen (z.B. "01 - Zutour - keine Abrechnung", "02 - Abholung Lieferant", usw). Es dient der detaillierten Kategorisierung von Touren für Reporting und Abrechnung. Je nach Tourart können verschiedene Tourtypen vorkommmen. Aus der Quelle plini (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_tourtyp_id,
        tms_tourtyp_lfd_nr,
        tms_tourtyp_bez

FROM DBP_DATA.L_TMS_TOURTYP ;