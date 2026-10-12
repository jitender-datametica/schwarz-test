--==============================================================
-- Table: tms_rechnung_det_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_rechnung_det_zu_1
   generated from Powerdesigner on Donnerstag, 24. April 2025 16:36:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_rechnung_det_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_rech_beleg_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Rechnung (Rechnungsnummer). Aus plrpos.beleg_nr'),
tms_rech_beleg_pos_id STRING(8) NOT NULL OPTIONS(description='Rechnungspositionsnummer. Aus plrpos.beleg_posnr'),
tms_rech_bezug_lfd_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Zuordnung / Referenz im Quellsystem.'),
bezugsart_id BIGNUMERIC(38,0)
OPTIONS(description='ID der Art_1 des Belegbezugs: 0 = undefiniert; 1 = Tour_1; 2 = Tourposition; 3 = Auftrag; 4 = Auftragsposition; 5 = HAU / Gesamtauftrag; 6 = Tag_1; 7 = E_Bordero; 8 = Teil transport; 9 = Gesamtrechnung; 10 = Teil Transport E Bordero; 100 = TRM'),
bezug_schluessel_nr STRING(30) OPTIONS(description='Gesamter Schluessel des Bezugsbelegs.'),
tms_ref_nr STRING(30) OPTIONS(description='Erster Teil des Bezugsbelegs, bspw. Auftrag'),
tms_ref_unter_nr STRING(30) OPTIONS(description='Zweiter Teil des Bezugsbelegs, bspw. Unterauftrag'),
tms_ref_pos_nr STRING(30) OPTIONS(description='Dritter Teil des Bezugsbelegs, bspw. Auftragsposition'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_rech_beleg_id, tms_rech_beleg_pos_id, tms_rech_bezug_lfd_nr) NOT ENFORCED
)
OPTIONS(description='TMS - Zuordnungstabelle zwischen den Rechnungspositionen und je nach Bezugsart anderen Belegen wie bspw. Auftragspositionen, Tourenpositionen, Gesamtrechnungen, etc.');