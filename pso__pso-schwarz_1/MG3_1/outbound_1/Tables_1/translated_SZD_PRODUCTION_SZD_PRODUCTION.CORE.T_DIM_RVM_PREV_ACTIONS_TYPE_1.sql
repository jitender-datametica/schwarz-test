CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_prev_actions_type_1 (
rvm_prev_action_type_id INTEGER NOT NULL
OPTIONS(description='The code defining the type of preventive maintenance activity for a deposit machine.'),
rvm_prev_action_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the type of preventive maintenance activity for a deposit machine in German.'),
rvm_prev_action_type_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of preventive maintenance activity for a deposit machine in English'),
rvm_prev_action_type_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of preventive maintenance activity for a deposit machine in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_prev_action_type_id) NOT ENFORCED
)
OPTIONS(description='This minor dimension lists the types of preventive maintenance activities that can be carried out for deposit machines.');