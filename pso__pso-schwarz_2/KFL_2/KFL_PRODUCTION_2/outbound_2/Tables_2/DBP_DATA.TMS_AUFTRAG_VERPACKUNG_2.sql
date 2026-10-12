--==============================================================
-- Table: tms_auftrag_verpackung_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_verpackung_2
   generated from Powerdesigner on Donnerstag, 24. April 2025 11:53:23
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag_verpackung_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_verpackung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Verpackung'),
tms_verpackung_lfd_nr STRING(10) NOT NULL OPTIONS(description='Identifier der Verpackung im Quellsystem'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plau.au_nr'),
tms_auftrag_unter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plau.au_unter_nr'),
tms_transportmittel_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Transportmittels auf dem die Verpackung verpackt wird.'),
anz_verpackung BIGNUMERIC(38,0) OPTIONS(description='Anzahl gleichartiger Verpackungen'),
tms_verpackung_bem_txt STRING(30) OPTIONS(description='Freitext für Bemerkungen zur Verpackung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_verpackung_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält Verpackunsinformationen zum Auftrag inklusive des genutzen Transportmittels der Verpackung.');