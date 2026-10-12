create or replace TABLE KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_DATA.TMS_AUFTRAG_TEXT_2 (
	MANDANT_ID NUMBER(38,0) NOT NULL COMMENT 'Mandant_2 im DWH',
	SYSTEM_ID NUMBER(38,0) NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
	TMS_AUFTRAG_TEXT_ID NUMBER(38,0) NOT NULL COMMENT 'ID des Freitextes welcher dem Auftrag hinzugefügt wurde.',
	TMS_SATZART_ID NUMBER(38,0) COMMENT 'ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:\n            0 = 1. Lieferscheinnummer\n            1 = 2. Lieferscheinnummer\n            2 = 3. Lieferscheinnummer\n             \n            Unter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte für''s Be-/Entladen erfasst.\n            87 = Bemerkung beim Beladen \n            88 = Bemerkung beim Entladen\n            \n            Über die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.',
	TMS_AUFTRAG_ID VARCHAR(30) NOT NULL COMMENT 'ID des Auftrags (Auftragsnummer). ',
	TMS_AUFTRAG_UNTER_ID NUMBER(38,0) NOT NULL COMMENT 'Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. ',
	TMS_TEXT_TYP_CD VARCHAR(30) COMMENT 'Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = Versandeinheit\n            D.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)\n            Dasselbe analog für NVEs.',
	AUFTRAG_TXT VARCHAR(500) COMMENT 'Inhalt des Freitextes',
	TD_UPDATE TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	TD_INSERT TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
	constraint PK_TMS_AUFTRAG_TEXT primary key (MANDANT_ID, SYSTEM_ID, TMS_AUFTRAG_TEXT_ID)
)COMMENT='TMS - Tabelle enthält mögliche Freitexte die im Quellsystem den Aufträgen manuell zugeordnet werden können für ergänzende Informationen / Bemerkungen / etc.'
;
