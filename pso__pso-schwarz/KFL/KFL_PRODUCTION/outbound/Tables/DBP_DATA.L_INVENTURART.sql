--==============================================================
-- Table: l_inventurart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_inventurart
   generated from Powerdesigner on Dienstag, 30. April 2024 18:15:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_inventurart (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
inventurart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Inventurart (international nicht identisch)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, inventurart_id) NOT ENFORCED
) OPTIONS(description='Lookup-Tabelle der Inventurarten.');