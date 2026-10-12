CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_cleaning_type_2 (
cleaning_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning type'),
cleaning_type_descr STRING(250) NOT NULL
OPTIONS(description='A  textual default description for the cleaning type in German'),
cleaning_type_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the cleaning type in English'),
cleaning_type_descr_de STRING(250) NOT NULL
OPTIONS(description='A  textual description for the cleaning type in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cleaning_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the cleaning type of deposit machines');