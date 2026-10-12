--==============================================================
-- Table: tms_auftrag_statistik_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_statistik_1
   generated from Powerdesigner on Montag, 10. März 2025 10:57:15
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag_statistik_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plaust.au_nr'),
tms_auftrag_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen'),
auftrag_statistik_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_auftrag_statistik_1 im Quellsystem. Aus plaust.aust_id'),
lief_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Lieferbeleg'),
kj_lief_beleg BIGNUMERIC(38,0)
OPTIONS(description='Kalenderjahr aus LFDAT. Lookup in besch_lief_1, -1 für keinen Treffer'),
lieferkunde_tms_gp_id STRING(30) OPTIONS(description='ID des tms_gp_1, welcher hier als Lieferkunde auftrifft'),
lieferkunde_tms_gp_typ_cd STRING(3)
OPTIONS(description='Code für den tms_gp_1-Typ, welcher hier als Lieferkunde auftrifft'),
tms_tour_id BIGNUMERIC(38,0) OPTIONS(description='Tournummer'),
dat_tour DATE OPTIONS(description='Tourdatum'),
betrag_kostenanteil BIGNUMERIC(38,16)
OPTIONS(description='Anteil des Kunden an den Eigenkosten oder Fremdkosten in Euro (NETTO)'),
tms_rech_beleg_id BIGNUMERIC(38,0) OPTIONS(description='Rechnungsnummer'),
dat_rechnung DATE OPTIONS(description='Rechnungsdatum'),
dat_leistung DATE OPTIONS(description='Datum der Leistung'),
abrechnungslauf_id BIGNUMERIC(38,0) OPTIONS(description='Abrechnungslauf'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_pos_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die statistische Daten zu TMS-Aufträgen. Aus der Quelle plaust (WANKO)');