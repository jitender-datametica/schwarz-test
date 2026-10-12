--==============================================================
-- Table: flw_l_vkorg
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_vkorg
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_vkorg (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
flw_verkaufsorganisation_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='Verkaufsorganisation aus vkorg'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup- Tabelle Verkaufsorganisation- SAP Tabelle TVKOT');