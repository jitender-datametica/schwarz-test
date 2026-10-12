--==============================================================
-- Table: tms_auftrag_beschraenkung_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_beschraenkung_zu
   generated from Powerdesigner on Mittwoch, 20. November 2024 16:34:13
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag_beschraenkung_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'),
tms_auftrag_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'),
tms_beschraenkung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Auftrags-spezifische Beschränkungen, z. B. Früh- oder Spätanlieferung, Zufahrt, …'),
tms_beschraenkung_pos_nr BIGNUMERIC(38,0)
OPTIONS(description='Beschrenkungsreihenfolge in der Quelltabelle. Keine ID. abgeleitet vom Spaltennamen, z.B. au_bes1 = 1, au_bes2 = 2, au_bes3 = 3'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_pos_id, tms_beschraenkung_id) NOT ENFORCED
)
OPTIONS(description='TMS - Zuordnungstabelle für Aufträge mit Einschränkungen, um die für den Auftrag geltenden Einschränkungen zu definieren. Aus der Quelle plau (WANKO)');