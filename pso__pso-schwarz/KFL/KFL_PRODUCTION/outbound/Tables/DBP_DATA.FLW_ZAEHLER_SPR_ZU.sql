--==============================================================
-- Table: flw_zaehler_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_zaehler_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_zaehler_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH. In der Regel länderbezogen'),
zaehler_id STRING(10) NOT NULL OPTIONS(description='Eindeutige ID des Zählers.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
system_id BIGNUMERIC(38,0) OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
zaehler_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Verbrauchszählers, z.Bsp. "OF Wasser Eismaschine"'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zaehler_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW -Sprachabhängige Bezeichnungen der Verbrauchszähler (Strom, Gas, Wasser)');