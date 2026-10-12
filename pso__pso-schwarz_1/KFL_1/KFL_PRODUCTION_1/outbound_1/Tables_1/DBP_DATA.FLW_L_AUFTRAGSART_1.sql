--==============================================================
-- Table: flw_l_auftragsart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_auftragsart_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_auftragsart_1 (
auftragsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Auftragsart aus auart'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle der Auftragsarten aus t003p');