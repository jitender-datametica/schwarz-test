--==============================================================
-- Table: crm_vorgang_touchpoint_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_vorgang_touchpoint_zu_1
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 11:05:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_vorgang_touchpoint_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
crm_vorgang_id STRING(36) NOT NULL OPTIONS(description='Ticket-ID.'),
touchpoint_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).'),
touchpoint_count BIGNUMERIC(38,0)
OPTIONS(description='Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (crm_vorgang_id, touchpoint_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='Assignment of respective touchpoints (touchpoints are departments the ticket gets sent to during the solution process) to ticket number, including counts.');