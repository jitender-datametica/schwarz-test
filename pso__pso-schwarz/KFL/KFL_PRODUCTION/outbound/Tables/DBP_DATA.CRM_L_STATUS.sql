--==============================================================
-- Table: crm_l_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_status
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_status (
crm_status_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Ticket Status ID z. B. Abgeschlossen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_status_id) NOT ENFORCED
) OPTIONS(description='KMR - Lookup für den Vorgangsstatus - MS Dynamics CRM');