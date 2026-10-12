--==============================================================
-- Table: geku_crm_eingangskanal_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geku_crm_eingangskanal_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geku_crm_eingangskanal_zu_1 (
geku_crm_eingangskanal_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mapping ID'),
geku_eingangskanal_id BIGNUMERIC(38,0) OPTIONS(description='GeKu Eingangskanal, z.Bsp. Fax, Telefon'),
crm_eingangskanal_id BIGNUMERIC(38,0) OPTIONS(description='Eingangskanal ID - z.B. Telefon, Email, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geku_crm_eingangskanal_id) NOT ENFORCED
) OPTIONS(description='Mapping Tabelle Geku CRM für den Eingangskanal');