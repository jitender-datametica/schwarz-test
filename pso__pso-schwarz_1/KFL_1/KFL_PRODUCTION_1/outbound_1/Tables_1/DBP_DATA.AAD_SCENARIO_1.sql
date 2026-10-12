--==============================================================
-- Table: aad_scenario_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aad_scenario_1
   generated from Powerdesigner on Mittwoch, 10. Mai 2023 08:29:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aad_scenario_1 (
scenario_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_grp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Unique Identifier of the Scenariogroup'),
dwh_created_tmsp DATETIME OPTIONS(description='Auto generate by Insert'),
dwh_updated_tmsp DATETIME OPTIONS(description='Auto generate by Update'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id) NOT ENFORCED
) OPTIONS(description=' Contains the scenario and scenariogroup mapping');