--==============================================================
-- Table: discountart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: discountart_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.discountart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
discountart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID Discountart'),
discountart_bez STRING(50) COLLATE 'und:ci' DEFAULT '' NOT NULL OPTIONS(description='Bezeichnung der Discountart'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='EK - Sprachzuordnungstabelle für Discountart');