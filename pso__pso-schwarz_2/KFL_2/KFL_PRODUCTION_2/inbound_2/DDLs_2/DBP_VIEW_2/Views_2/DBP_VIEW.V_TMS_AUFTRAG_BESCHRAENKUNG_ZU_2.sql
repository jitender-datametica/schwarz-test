CREATE OR REPLACE VIEW DBP_VIEW.V_TMS_AUFTRAG_BESCHRAENKUNG_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH'
  ,system_id                                COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.'
  ,tms_auftrag_id                           COMMENT 'ID des Auftrags (Auftragsnummer). Aus plau.au_nr'
  ,tms_auftrag_pos_id                       COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'
  ,tms_beschraenkung_id                     COMMENT 'ID der Auftrags-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'
  ,tms_beschraenkung_pos_nr                 COMMENT 'Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. au_bes1 = 1, au_bes2 = 2, au_bes3 = 3'
)
COMMENT = 'TMS - Zuordnungstabelle für Aufträge mit Einschränkungen, um die für den Auftrag geltenden Einschränkungen zu definieren. Aus der Quelle plau (WANKO)'
 AS 
    SELECT 
        mandant_id,
        system_id,
        tms_auftrag_id,
        tms_auftrag_pos_id,
        tms_beschraenkung_id,
        tms_beschraenkung_pos_nr

FROM DBP_DATA.TMS_AUFTRAG_BESCHRAENKUNG_ZU_2 ;