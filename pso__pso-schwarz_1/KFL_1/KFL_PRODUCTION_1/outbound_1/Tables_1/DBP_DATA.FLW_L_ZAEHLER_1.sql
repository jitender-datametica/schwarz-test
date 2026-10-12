--==============================================================
-- Table: flw_l_zaehler_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_zaehler_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:40 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_zaehler_1 (
zaehler_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Eindeutige ID des Zählers.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
zaehlerart STRING(20) COLLATE 'und:ci' NOT NULL OPTIONS(description='Art_1 des Zählers, z.Bsp. Wasser'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookuptabelle für Stammdaten der Verbrauchszähler (Strom, Gas, Wasser)');