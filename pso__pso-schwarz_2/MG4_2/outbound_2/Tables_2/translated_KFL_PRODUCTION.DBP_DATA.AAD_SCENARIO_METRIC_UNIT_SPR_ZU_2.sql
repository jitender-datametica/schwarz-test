CREATE OR REPLACE TABLE kfl_production_dbp_data.aad_scenario_metric_unit_spr_zu_2 (
scenario_metric_unit_id INTEGER NOT NULL
OPTIONS(description='Unique identifier of the metric that is monitored in fraud detection scenarios'),
spr_id INTEGER NOT NULL OPTIONS(description='ID der Sprache'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH - ein Mandant_2 pro Land.'),
scenario_metric_unit_descr STRING(255) OPTIONS(description='Scenario´s metric unit_2 name in the corresponding language'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scenario_metric_unit_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='Contains the description of the scenario metric units in the corresponding languages');