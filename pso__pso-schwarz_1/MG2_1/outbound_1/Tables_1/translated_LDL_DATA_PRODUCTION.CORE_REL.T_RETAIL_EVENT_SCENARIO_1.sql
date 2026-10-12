CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_retail_event_scenario_1 (
retail_event_scenario_id INTEGER NOT NULL
OPTIONS(description='The numeric identifier for the scenario which is represented by the retail event.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
retail_event_scenario_name STRING(100) NOT NULL
OPTIONS(description='The name of the business scenario which is represented by the retail event.'),
retail_event_scenario_descr STRING(250) NOT NULL
OPTIONS(description='A textual description of the conditions which determine the business scenario.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (retail_event_scenario_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the business scenario which the retail event represents, e.g. regular sales_1, cancelled sales_1, deposit return, etc. The scenario is calculated from a number of other attributes, so it is derived information.');