--==============================================================
-- Table: tms_auftrag_text
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_text
   generated from Powerdesigner on Donnerstag, 24. April 2025 15:44:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag_text (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftrag_text_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Freitextes welcher dem Auftrag hinzugefügt wurde.'),
tms_satzart_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Satzart. In der Beschaffungslogistik werden hier grundsätzlich Lieferscheinnummern erfasst je nachdem wie viele Lieferscheine es zu einem Auftrag gab, z.B. bei 3 Lieferscheinnummern zu einem Auftrag:            0 = 1. Lieferscheinnummer            1 = 2. Lieferscheinnummer            2 = 3. Lieferscheinnummer                         Unter ID 87 und 88 werden zu einem Auftrag Bemerkungstexte für\'s Be-/Entladen erfasst.            87 = Bemerkung beim Beladen             88 = Bemerkung beim Entladen                        Über die ID der Satzart wird gesteuert, wo der Text in der WANKO Maske angezeigt wird.'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). '),
tms_auftrag_unter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. '),
tms_text_typ_cd STRING(30)
OPTIONS(description='Angabe eines Texttypen. Diese werden in der PLINI konfiguriert: L = Lieferschein; N = Versandeinheit            D.h. alle Lieferscheine eines Auftrags können über tms_auftrag_id und tms_text_typ_cd = L selektiert werden (unabhängig von der Satzartnr)            Dasselbe analog für NVEs.'),
auftrag_txt STRING(500) OPTIONS(description='Inhalt des Freitextes'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftrag_text_id) NOT ENFORCED
)
OPTIONS(description='TMS - Tabelle enthält mögliche Freitexte die im Quellsystem den Aufträgen manuell zugeordnet werden können für ergänzende Informationen / Bemerkungen / etc.');