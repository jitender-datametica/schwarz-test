CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_text (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_auftrag_text_id
OPTIONS(description='ID des Freitextes welcher dem Auftrag hinzugefügt wurde.'), tms_satzart_id
OPTIONS(description='ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:\n0 = 1. Lieferscheinnummer\n1 = 2. Lieferscheinnummer\n2 = 3. Lieferscheinnummer\n\nUnter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte für\'s Be-/Entladen erfasst.\n87 = Bemerkung beim Beladen\n88 = Bemerkung beim Entladen\n\nÜber die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.'),
tms_auftrag_id OPTIONS(description='ID des Auftrags (Auftragsnummer). '), tms_auftrag_unter_id
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. '), tms_text_typ_cd
OPTIONS(description='Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = Versandeinheit\nD.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)\nDasselbe analog für NVEs.'),
auftrag_txt OPTIONS(description='Inhalt des Freitextes'))
OPTIONS(DESCRIPTION = `TMS - Tabelle enthält mögliche Freitexte die im Quellsystem den Aufträgen manuell zugeordnet werden können für ergänzende Informationen / Bemerkungen / etc.`)
AS SELECT mandant_id,
 system_id,
 tms_auftrag_text_id,
 tms_satzart_id,
 tms_auftrag_id,
 tms_auftrag_unter_id,
 tms_text_typ_cd,
 auftrag_txt
FROM kfl_production_dbp_data.tms_auftrag_text;