--==============================================================
-- Table: flw_vw_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_vw_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_vw_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
vw_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Vertriebswegs aus vtext'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_vw_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnungen der Vertriebswege aus tvtwt');