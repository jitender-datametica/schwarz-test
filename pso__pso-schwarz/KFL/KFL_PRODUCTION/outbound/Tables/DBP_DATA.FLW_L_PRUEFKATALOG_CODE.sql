--==============================================================
-- Table: flw_l_pruefkatalog_code
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_pruefkatalog_code
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_pruefkatalog_code (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Katalogart'),
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der codegruppe'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
pruefcode_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Prüfcodes aus code'),
auswahlmenge BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Auswahlmenge aus auswahlmge. Im DWH werden nur numerische Werte zugelassen'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id, auswahlmenge) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle der Prüfcodes aus qpac');