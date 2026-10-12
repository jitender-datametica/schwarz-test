--==============================================================
-- Table: flw_qual_meldung_det
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_qual_meldung_det
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_qual_meldung_det (
qual_meldung_id INTEGER NOT NULL OPTIONS(description='eindeutige ID der Qualitätsmeldung aus qmnum'),
qual_meldung_pos_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Positionsnummer im Positionssatz aus fenum'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Katalogart'),
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der codegruppe'),
pruefcode_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Fehlercode aus fecod'),
fehlgrund_id STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Fehl- / Verspätungsgrundes aus txt  - wird aus Modellierungsgründen zur ID erklärt'),
fehlerklasse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Fehlerklasse, z.Bsp. 00 aus fehlerklasse'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (qual_meldung_id, qual_meldung_pos_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Qualitätsmeldung - Positionen aus qmfe - MULTISET');