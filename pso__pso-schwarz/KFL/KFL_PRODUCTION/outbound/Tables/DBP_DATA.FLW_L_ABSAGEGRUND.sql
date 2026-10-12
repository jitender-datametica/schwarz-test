--==============================================================
-- Table: flw_l_absagegrund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_absagegrund
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_absagegrund (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
absagegrund_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup der Absagegründe aus der Tabelle tvag');