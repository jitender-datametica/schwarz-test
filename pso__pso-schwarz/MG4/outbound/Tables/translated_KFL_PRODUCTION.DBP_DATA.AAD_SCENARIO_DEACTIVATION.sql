CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_scenario_deactivation (
scenario_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenario'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
dwh_created_tmsp DATETIME OPTIONS(description='Auto generate by Insert'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Contains information which AAD fraud scenarios are deactivated for which countries (mandant_id)');