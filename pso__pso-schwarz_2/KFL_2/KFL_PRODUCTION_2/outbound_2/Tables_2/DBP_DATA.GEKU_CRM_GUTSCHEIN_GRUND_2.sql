--==============================================================
-- Table: geku_crm_gutschein_grund_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_gutschein_grund_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_gutschein_grund_2 (
geku_crm_gutschein_grund_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mapping ID'),
ausgeber_id STRING(10) COLLATE 'und:ci' OPTIONS(description='Gutschein_2 Grund Id aus GEKU'),
crm_gutschein_grund_id BIGNUMERIC(38,0) OPTIONS(description='Grund der Gutscheinausgabe ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_gutschein_grund_id) NOT ENFORCED
) OPTIONS(description='Mapping Tabelle Geku CRM für Gutschein_2 Grund');