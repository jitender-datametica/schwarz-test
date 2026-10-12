--==============================================================
-- Table: crm_l_touchpoint_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_l_touchpoint_2
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 09:46:08
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_l_touchpoint_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH.'),
touchpoint_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, touchpoint_id) NOT ENFORCED
)
OPTIONS(description='Lookup for touchpoints (touchpoints are departments the ticket gets sent to during the solution process).');