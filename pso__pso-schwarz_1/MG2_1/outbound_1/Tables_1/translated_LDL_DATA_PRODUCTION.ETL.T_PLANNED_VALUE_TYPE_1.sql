CREATE OR REPLACE TABLE ldl_data_production_etl.t_planned_value_type_1 (
kpi_column_name STRING(100),
key_type_cd STRING(20),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
planned_val_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of value for which a plan is made.'),
planned_val_type_id INTEGER NOT NULL
OPTIONS(description='The number which identifies the kind of value for which a plan is made in the planning tool. E.g. 157 for net revenue.'),
planned_val_role_cd STRING(20)
OPTIONS(description='The code which identifies the role or context for which the value is planned.'),
planning_process_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the planning process which defines this planned value type.')
);