CREATE OR REPLACE TABLE ldl_data_production_etl.t_planned_value_role_1 (
planned_val_role_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the role or context for which the value is planned.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
planned_val_role_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the role or context for which the value is planned.'),
PRIMARY KEY (planned_val_role_cd, lang_cd) NOT ENFORCED
);