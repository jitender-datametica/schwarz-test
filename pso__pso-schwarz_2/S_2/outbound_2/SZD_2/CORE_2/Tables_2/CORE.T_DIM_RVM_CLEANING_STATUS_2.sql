CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_cleaning_status_2 (
cleaning_status_cd STRING(50) NOT NULL OPTIONS(description='The code for the cleaning status_2'),
cleaning_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the cleaning status_2 in German'),
cleaning_status_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the cleaning status_2 in English'),
cleaning_status_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the cleaning status_2 in German'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (cleaning_status_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the cleaning status_2 of deposit machines');