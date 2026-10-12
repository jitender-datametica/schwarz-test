--==============================================================
-- Table: flw_fehlerklasse_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_fehlerklasse_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_fehlerklasse_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
fehlerklasse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Fehlerklasse, z.Bsp. 00 aus fehlerklasse'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
fehlerklasse_bez STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Fehlerklasse, z.Bsp. 70 Punkte, aus kurztext'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, fehlerklasse_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Fehlerklasse aus tq17t');