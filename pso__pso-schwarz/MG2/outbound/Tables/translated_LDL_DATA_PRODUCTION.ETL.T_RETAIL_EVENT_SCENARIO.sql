CREATE OR REPLACE TABLE ldl_data_production_etl.t_retail_event_scenario (
retail_event_scenario_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
retail_event_scenario_name STRING(100) NOT NULL
OPTIONS(description='The name of the business scenario which is represented by the retail event.'),
retail_event_scenario_descr STRING(250) NOT NULL
OPTIONS(description='A textual description of the conditions which determine the business scenario.'),
PRIMARY KEY (retail_event_scenario_id, lang_cd) NOT ENFORCED
);