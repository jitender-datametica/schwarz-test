--==============================================================
-- Table: geku_crm_schaedlingsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_schaedlingsart_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_schaedlingsart_2 (
geku_crm_schaedlingsart_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mapping ID'),
schaedlingsart_id BIGNUMERIC(38,0) OPTIONS(description='Schaedlingsart ID aus GEKU'),
crm_schaedlingsart_id BIGNUMERIC(38,0) OPTIONS(description='Schaedlingsart ID aus CRM'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_schaedlingsart_id) NOT ENFORCED
) OPTIONS(description='Mapping Tabelle Geku CRM für Schaedlingsarten');