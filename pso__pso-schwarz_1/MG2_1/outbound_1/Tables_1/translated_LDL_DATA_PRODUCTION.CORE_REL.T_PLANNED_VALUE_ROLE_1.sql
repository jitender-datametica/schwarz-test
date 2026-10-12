CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_planned_value_role_1 (
planned_val_role_cd STRING(20) NOT NULL
OPTIONS(description='The code which identifies the role or context for which the value is planned.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
planned_val_role_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the role or context for which the value is planned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (planned_val_role_cd, lang_cd) NOT ENFORCED
)
OPTIONS(description='The planned value may play a certain role or be put into a certain context. E.g. revenue for an internal company may be planned both for its role as a sales_1 company and for its role as a delivery company. Different values may be planned for each role.');