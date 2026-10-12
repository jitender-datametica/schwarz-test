CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_beschraenkung_zu_1 (mandant_id
OPTIONS(description='Mandant_1 im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftrag_id
OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'), tms_auftrag_pos_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'), tms_beschraenkung_id
OPTIONS(description='ID der Auftrags-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'),
tms_beschraenkung_pos_nr
OPTIONS(description='Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. au_bes1 = 1, au_bes2 = 2, au_bes3 = 3'))
OPTIONS(DESCRIPTION = `TMS - ZUORDNUNGSTABELLE FÜR AUFTRÄGE MIT EINSCHRÄNKUNGEN, UM DIE FÜR DEN AUFTRAG GELTENDEN EINSCHRÄNKUNGEN ZU DEFINIEREN. AUS DER QUELLE PLAU (WANKO)`)
AS SELECT mandant_id,
 system_id,
 tms_auftrag_id,
 tms_auftrag_pos_id,
 tms_beschraenkung_id,
 tms_beschraenkung_pos_nr
FROM kfl_production_dbp_data.tms_auftrag_beschraenkung_zu_1;