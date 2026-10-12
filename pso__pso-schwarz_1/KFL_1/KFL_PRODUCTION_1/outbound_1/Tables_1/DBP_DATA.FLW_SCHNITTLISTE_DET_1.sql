--==============================================================
-- Table: flw_schnittliste_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnittliste_det_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnittliste_det_1 (
schnittliste_id INTEGER NOT NULL OPTIONS(description='ID der Schnittliste aus ctlnr'),
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL OPTIONS(description='ID des Sekundärschlüssels aus sckey'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
schnitt_verwendung_prozent NUMERIC(9,2) NOT NULL OPTIONS(description='Proenzsatz der Schnitt-Verwendung aus cutpr'),
flw_art_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Im DWH erzeugter numerischer Schlüssel für die Artikelnummer.'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
menge NUMERIC(18,3) DEFAULT 0 NOT NULL OPTIONS(description='Menge'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnittliste_id, schnitt_id, sek_schl_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Schnittlistenpositionen aus ctlp');