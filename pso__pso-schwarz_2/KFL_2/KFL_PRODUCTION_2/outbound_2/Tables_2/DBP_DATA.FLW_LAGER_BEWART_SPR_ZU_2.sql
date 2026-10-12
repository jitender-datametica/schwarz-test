--==============================================================
-- Table: flw_lager_bewart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lager_bewart_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_lager_bewart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
lager_bewart_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Lager Bewegungsart aus bwart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 ist deutsch'),
lager_bewart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Lager-Bewegungsart'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Lager-Bewegungsarten aus t156t');