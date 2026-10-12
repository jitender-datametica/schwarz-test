--==============================================================
-- Table: in_l_auftragsart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_auftragsart_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_auftragsart_1 (
auftragsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Auftragsart aus auart'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='IMS - Lookuptabelle der Auftragsarten aus t003p');