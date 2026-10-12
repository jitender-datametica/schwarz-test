--==============================================================
-- Table: crm_touchpoint_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crm_touchpoint_spr_zu
   generated from Powerdesigner on Dienstag, 18. Oktober 2022 11:07:59
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crm_touchpoint_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
touchpoint_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Several count-fields that describe the amount of times that the ticket has been in each touchpoint (department, customer, store etc.).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Language ID.'),
touchpoint_bez STRING(80) OPTIONS(description='Description of each touchpoint ID.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (touchpoint_id, spr_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='spr_zu-table for touchpoints (touchpoints are departments the ticket gets sent to during the solution process).');