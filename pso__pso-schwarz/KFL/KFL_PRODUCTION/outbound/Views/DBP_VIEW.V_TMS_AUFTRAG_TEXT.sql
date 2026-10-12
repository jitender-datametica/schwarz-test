CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_auftrag_text (mandant_id OPTIONS(description='Mandant im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), 
tms_auftrag_text_id OPTIONS(description='ID des Freitextes welcher dem Auftrag hinzugefügt wurde.'), 
tms_satzart_id OPTIONS(description='ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:0 = 1. Lieferscheinnummer1 = 2. Lieferscheinnummer2 = 3. Lieferscheinnummer Unter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte fürs Be-/Entladen erfasst.87 = Bemerkung beim Beladen 88 = Bemerkung beim EntladenÜber die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.'),
tms_auftrag_id OPTIONS(description='ID des Auftrags (Auftragsnummer). '), 
tms_auftrag_unter_id OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. '), 
tms_text_typ_cd OPTIONS(description='Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = VersandeinheitD.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)Dasselbe analog für NVEs.'),
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