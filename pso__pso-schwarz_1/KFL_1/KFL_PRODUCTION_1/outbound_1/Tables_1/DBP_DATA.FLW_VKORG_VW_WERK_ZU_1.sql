--==============================================================
-- Table: flw_vkorg_vw_werk_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_vkorg_vw_werk_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_vkorg_vw_werk_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation aus vkorg'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_vw_id, werk_id) NOT ENFORCED
) OPTIONS(description='FLW - Zuordnung Vertriebsweg - Verkaufsorganisation - Werk aus tvkwz');