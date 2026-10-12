--==============================================================
-- Table: handling_unit_ewm
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: handling_unit_ewm
   generated from Powerdesigner on Mittwoch, 26. Januar 2022 07:27:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_ewm (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
log_guid STRING(32) NOT NULL OPTIONS(description='Warenbewegungslog HU'),
handling_unit_guid STRING(32) NOT NULL OPTIONS(description='Handling Unit GUID'),
quelle STRING(10) COLLATE 'und:ci' OPTIONS(description='Quelltabelle SAP'),
parent_handling_unit_guid STRING(32) OPTIONS(description='Handling Unit GUID Parent'),
lageraufgabe_id BIGNUMERIC(38,0) OPTIONS(description='Lageraufgabe'),
handling_unit_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Handling Unit ID'),
packmittel_guid STRING(32) OPTIONS(description='Packmittel GUID'),
lagernummer_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Lagernummer'),
lagereinheitentyp_id STRING(4) COLLATE 'und:ci' OPTIONS(description='Lagereinheitentyp'),
gewicht_brutto NUMERIC(15,3) OPTIONS(description='Bruttogewicht'),
gewicht_netto NUMERIC(15,3) OPTIONS(description='Nettogewicht'),
gewicht_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Gewichtseinheit'),
eigengewicht NUMERIC(15,3) OPTIONS(description='Eigengewicht HU'),
eigengewicht_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Einheit Eigengewicht HU'),
volumen_brutto NUMERIC(15,3) OPTIONS(description='Bruttovolumen'),
volumen_netto NUMERIC(15,3) OPTIONS(description='Nettovolumen'),
volumen_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Volumeneinheit'),
eigenvolumen NUMERIC(15,3) OPTIONS(description='Eigenvolumen HU'),
eigenvolumen_einh_id STRING(3) COLLATE 'und:ci' OPTIONS(description='Einheit Eigenvolumen HU'),
datzeit_lageraufgabe_bestaetigung TIMESTAMP
OPTIONS(description='Bestätigung Lageraufgabe UTC-Zeitstempel in Langform (JJJJMMTThhmmss,mmmuuun)'),
anzahl_stellplaetze NUMERIC(5,2) OPTIONS(description='Anzahl Stellplätze'),
menge_gefahrgut NUMERIC(7,2) OPTIONS(description='Menge Gefahrgut'),
status_id_intern STRING(1) COLLATE 'und:ci' OPTIONS(description='Internet Status einer HU'),
top_hu_fg BIGNUMERIC(38,0) OPTIONS(description='Übergeordnete HU'),
bottom_hu_fg BIGNUMERIC(38,0) OPTIONS(description='Untergeordnete HU'),
konsolidierungsgruppe_id STRING(10) OPTIONS(description='Konsolidierungsgruppe'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
);