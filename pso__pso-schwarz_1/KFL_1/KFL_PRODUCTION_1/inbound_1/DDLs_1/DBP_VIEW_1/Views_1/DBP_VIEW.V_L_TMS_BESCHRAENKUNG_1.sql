CREATE OR REPLACE VIEW DBP_VIEW.V_L_TMS_BESCHRAENKUNG_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_beschraenkung_id                     COMMENT 'ID der Beschränkung (Nummer der Beschränkung). Aus plbes.besnr'
  ,tms_beschraenkung_lfd_nr                 COMMENT 'SKey für die Tabelle l_tms_beschraenkung_1 im Quellsystem. Aus plbes.bes_id'
  ,tms_beschraenkung_bez                    COMMENT 'Bezeichnung zur Beschränkung'
)
COMMENT = 'TMS - Referenztabelle zur Verwaltung von Einschränkungen für Touren und Geschäftspartnern, z. B. nur Früh- und/oder Spätanlieferung. Aus der Quelle plbes (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_beschraenkung_id,
        tms_beschraenkung_lfd_nr,
        tms_beschraenkung_bez

FROM DBP_DATA.L_TMS_BESCHRAENKUNG_1 ;