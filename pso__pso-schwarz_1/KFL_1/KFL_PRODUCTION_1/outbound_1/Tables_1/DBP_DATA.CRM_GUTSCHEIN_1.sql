--==============================================================
-- Table: crm_gutschein_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_gutschein_1
   generated from Powerdesigner on Thursday, September 8, 2022 2:55:04 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_gutschein_1 (
mandant_id BIGNUMERIC(38,0) OPTIONS(description='Mandant_1 im DWH.'),
crm_gutschein_id STRING(36) COLLATE 'und:ci' NOT NULL OPTIONS(description='Gutschein_1 ID (GUID) aus CRM.'),
crm_vorgang_id STRING(36) COLLATE 'und:ci' OPTIONS(description='Vorgang ID (GUID) aus CRM.'),
crm_gutschein_grund_id BIGNUMERIC(38,0) OPTIONS(description='Grund der Gutscheinausgabe ID.'),
gutschein_nummer STRING(100) COLLATE 'und:ci' OPTIONS(description='Gutscheinnummer.'),
kostenstelle_id STRING(100) COLLATE 'und:ci' OPTIONS(description='Kostenstelle.'),
gutschein_wert NUMERIC(10,2) NOT NULL OPTIONS(description='Gutscheinwert.'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='KMR - Gutscheindaten aus der CRM Entität kl_voucher - MS Dynamics CRM');