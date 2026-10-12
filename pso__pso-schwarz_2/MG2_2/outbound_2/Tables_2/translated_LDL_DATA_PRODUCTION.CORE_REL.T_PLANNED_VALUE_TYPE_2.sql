CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_planned_value_type_2 (
planned_val_type_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
planned_val_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of value for which a plan is made.'),
planned_val_type_id INTEGER NOT NULL
OPTIONS(description='The number which identifies the kind of value for which a plan is made in the planning tool. E.g. 157 for net revenue.'),
planned_val_role_cd STRING(20)
OPTIONS(description='The code which identifies the role or context for which the value is planned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
planning_process_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the planning process which defines this planned value type.'),
PRIMARY KEY (planned_val_type_sid, lang_cd) NOT ENFORCED
)
OPTIONS(description='This minor entity defines the kind of value for which a plan is made. E.g. a forecast for revenue or customer count.');