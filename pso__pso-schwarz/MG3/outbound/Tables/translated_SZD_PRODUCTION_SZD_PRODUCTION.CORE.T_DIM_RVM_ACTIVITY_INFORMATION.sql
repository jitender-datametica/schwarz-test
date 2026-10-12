CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_activity_information (
rvm_active_id INTEGER NOT NULL OPTIONS(description='The id showing the activity state of the deposit machine.'),
rvm_active_name STRING(100) NOT NULL
OPTIONS(description='A textual default description for the activity state of a deposit machine in German.'),
rvm_active_name_en STRING(100) NOT NULL
OPTIONS(description='A textual description for the activity state of a deposit machine in English.'),
rvm_active_name_de STRING(100) NOT NULL
OPTIONS(description='A textual description for the activity state of a deposit machine in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The identifier for the first source the table refers to.'),
PRIMARY KEY (rvm_active_id) NOT ENFORCED
) OPTIONS(description='This minor dimension describes the activity state of the Deposit Machine.');