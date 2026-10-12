--==============================================================
-- Table: flw_pruefkatalog_code_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_pruefkatalog_code_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_pruefkatalog_code_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Katalogart'),
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der codegruppe'),
pruefcode_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Prüfcodes aus code'),
version_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Versionsnummer aus version1'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
pruefkatalog_code_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurbezeichnung zum code aus kurztext'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, version_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Prüfcodes aus qpct');