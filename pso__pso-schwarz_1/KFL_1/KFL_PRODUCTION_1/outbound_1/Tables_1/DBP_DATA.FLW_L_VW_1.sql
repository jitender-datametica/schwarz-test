--==============================================================
-- Table: flw_l_vw_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_vw_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_vw_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
flw_vw_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Vertriebswegs aus vtweg'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, flw_vw_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup Tabelle der Vertriebswege aus tvtw_t');