CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_scenario_grp_spr_zu (
scenario_grp_id INTEGER NOT NULL OPTIONS(description='Unique Identifier of the Scenariogroup'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH - ein Mandant pro Land.'),
scenario_grp_descr STRING(255) OPTIONS(description='Scenariogroup´s name in the corresponding language'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_grp_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Scenariogroup´s name in the corresponding language');