CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_sort_type_2 (
rvm_sort_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system sort type'),
rvm_sort_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the direction from where the deposit machine can be emptied in German. (left / right / front / back)'),
rvm_sort_type_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the direction from where the deposit machine can be emptied in English. (left / right / front / back)'),
rvm_sort_type_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the direction from where the deposit machine can be emptied in German. (left / right / front / back)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_sort_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the sort types of deposit machines (e.g. Standard / MotorEnd)');