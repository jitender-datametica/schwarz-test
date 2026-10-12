CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_orientation_1 (
rvm_orientation_cd STRING(50) NOT NULL
OPTIONS(description='The code for the deposit machine background system orientation'),
rvm_orientation_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the deposit machine background system orientation in English.'),
rvm_orientation_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the deposit machine background system orientation in German.'),
rvm_orientation_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the deposit machine background system orientation in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_orientation_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the orientation of a reusable background system e.g. left');