--==============================================================
-- Table: tms_auftrag_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: tms_auftrag_det_2
   generated from Powerdesigner on Freitag, 25. April 2025 14:06:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tms_auftrag_det_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
tms_auftrag_id STRING(30) NOT NULL OPTIONS(description='ID des Auftrags (Auftragsnummer). Aus plps.au_nr'),
tms_auftrag_unter_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auftragsunternummer zur Aufteilung eines Auftrages in Teillieferungen. Aus plps.au_unter_nr'),
tms_auftrag_pos_id STRING(5) NOT NULL
OPTIONS(description='Laufende Nummer zur Identifizierung einer Auftragsposition innerhalb eines Auftrages. Aus plps.au_lfnr'),
tms_auftrag_det_lfd_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='SKey für die Tabelle tms_auftrag_det_2 im Quellsystem. Aus plps.au_lfnr'),
art_id BIGNUMERIC(38,0) OPTIONS(description='Artikelnummer der Auftragsposition'),
orig_art_nr STRING(30)
OPTIONS(description='Artikelnummer der Auftragsposition inklusive aller Zeichen (alphanumerisch und Sonderzeichen), falls vorhanden.'),
menge_kommissioniert BIGNUMERIC(38,2) OPTIONS(description='Fertig kommissionierte Menge'),
status_fertig_cd STRING(3)
OPTIONS(description='Fertig Kennzeichen: F = Kommissionierung abgeschlossen weil entweder ausreichende Menge kommissioniert wurde oder weil der Rest zur Fehlmenge erklärt wurde.'),
tms_transportmittel_id BIGNUMERIC(38,0) OPTIONS(description='ID des Transportmittels.'),
anz_transportmittel BIGNUMERIC(38,0) OPTIONS(description='Anzahl des Transportmittels.'),
wareneingang_beleg_id STRING(30) OPTIONS(description='Belegnummer des Wareneingangs, auf T = EBELN.'),
dat_wareneingang DATE OPTIONS(description='Datum des Wareneingangs'),
tms_auftrag_orig_id STRING(30)
OPTIONS(description='Originale Auftragsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.'),
tms_auftrag_orig_unter_id BIGNUMERIC(38,0)
OPTIONS(description='Originale Positionsnummer der Auftragsposition, bezieht sich auf SAP Aufträge.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, system_id, tms_auftrag_id, tms_auftrag_unter_id, tms_auftrag_pos_id) NOT ENFORCED
)
OPTIONS(description='TMS - Die Tabelle enthält die relevanten Informationen zu einem Distributionsauftrag auf Positionsebene.');