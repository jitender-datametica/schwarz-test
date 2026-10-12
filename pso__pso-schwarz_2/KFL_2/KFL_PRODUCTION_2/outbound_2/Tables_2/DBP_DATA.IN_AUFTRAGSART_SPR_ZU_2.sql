--==============================================================
-- Table: in_auftragsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_auftragsart_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_auftragsart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
auftragsart_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Auftragsart aus auart'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
auftragsart_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der Auftragsart aus txt'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Sprachabhängige Bezeichnung der Auftragsarten aus t003p');