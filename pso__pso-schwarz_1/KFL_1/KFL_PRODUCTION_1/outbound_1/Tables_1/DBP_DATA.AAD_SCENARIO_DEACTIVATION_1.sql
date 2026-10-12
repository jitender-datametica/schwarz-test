--==============================================================
-- Table: aad_scenario_deactivation_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_deactivation_1
   generated from Powerdesigner on Mittwoch, 31. Mai 2023 07:01:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_deactivation_1 (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH - ein Mandant_1 pro Land.'),
dwh_created_tmsp DATETIME OPTIONS(description='Auto generate by Insert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Contains information which AAD fraud scenarios are deactivated for which countries (mandant_id)');