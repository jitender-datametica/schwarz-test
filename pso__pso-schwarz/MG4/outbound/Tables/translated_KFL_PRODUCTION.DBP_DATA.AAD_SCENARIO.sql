CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_scenario (
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
scenario_grp_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenariogroup'),
dwh_created_tmsp DATETIME OPTIONS(description='Auto generate by Insert'),
dwh_updated_tmsp DATETIME OPTIONS(description='Auto generate by Update'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id) NOT ENFORCED
) OPTIONS(description=' Contains the scenario and scenariogroup mapping');