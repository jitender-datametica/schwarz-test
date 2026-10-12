--==============================================================
-- Table: inventurart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: inventurart_spr_zu_1
   generated from Powerdesigner on Dienstag, 30. April 2024 18:14:48
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.inventurart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
inventurart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Inventurart (international nicht identisch)'),
inventurart_bez STRING(100) NOT NULL OPTIONS(description='Bezeichnung der Inventurart.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, inventurart_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnungen der Inventurarten.');