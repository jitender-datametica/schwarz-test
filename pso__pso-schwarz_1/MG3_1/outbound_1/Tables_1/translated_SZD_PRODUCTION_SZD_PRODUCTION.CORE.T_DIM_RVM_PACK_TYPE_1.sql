CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_pack_type_1 (
rvm_pack_type_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system packtype'),
rvm_pack_type_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the deposit machine background system packtype in English.'),
rvm_pack_type_descr STRING(250) NOT NULL
OPTIONS(description='A textua defaultl description for the deposit machine background system packtype in German.'),
rvm_pack_type_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the deposit machine background system packtype in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_pack_type_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the packtype of a reusable background system e.g. Dualsort');