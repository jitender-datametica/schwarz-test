create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TMS_AUFTRAG_TEXT(
	MANDANT_ID COMMENT 'Mandant im DWH',
	SYSTEM_ID COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_AUFTRAG_TEXT_ID COMMENT 'ID des Freitextes welcher dem Auftrag hinzugefügt wurde.',
	TMS_SATZART_ID COMMENT 'ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:\n0 = 1. Lieferscheinnummer\n1 = 2. Lieferscheinnummer\n2 = 3. Lieferscheinnummer\n \nUnter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte für''s Be-/Entladen erfasst.\n87 = Bemerkung beim Beladen \n88 = Bemerkung beim Entladen\n\nÜber die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.',
	TMS_AUFTRAG_ID COMMENT 'ID des Auftrags (Auftragsnummer). ',
	TMS_AUFTRAG_UNTER_ID COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. ',
	TMS_TEXT_TYP_CD COMMENT 'Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = Versandeinheit\nD.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)\nDasselbe analog für NVEs.',
	AUFTRAG_TXT COMMENT 'Inhalt des Freitextes'
) COMMENT='TMS - Tabelle enthält mögliche Freitexte die im Quellsystem den Aufträgen manuell zugeordnet werden können für ergänzende Informationen / Bemerkungen / etc.'
 as 
    SELECT 
        mandant_id,
        system_id,
        tms_auftrag_text_id,
        tms_satzart_id,
        tms_auftrag_id,
        tms_auftrag_unter_id,
        tms_text_typ_cd,
        auftrag_txt

FROM DBP_DATA.TMS_AUFTRAG_TEXT ;
