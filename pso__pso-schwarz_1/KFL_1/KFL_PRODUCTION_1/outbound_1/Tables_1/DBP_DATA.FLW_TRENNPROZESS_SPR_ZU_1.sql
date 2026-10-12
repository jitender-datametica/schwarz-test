--==============================================================
-- Table: flw_trennprozess_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_trennprozess_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_trennprozess_spr_zu_1 (
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
trennprozess_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Trennprozesses aus trpro. Werte sind SDZ oder ZERL'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
trennprozess_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Trennprozesses aus txt40, z.Bsp. "Zerlegung"'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werk_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Trennprozess Bezeichnungen aus spmeat_tttrprt');