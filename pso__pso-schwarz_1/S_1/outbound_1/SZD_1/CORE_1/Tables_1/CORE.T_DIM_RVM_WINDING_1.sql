CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_winding_1 (
rvm_winding_cd STRING(50) NOT NULL OPTIONS(description='The code for the deposit machine background system winding'),
rvm_winding_descr STRING(250) NOT NULL
OPTIONS(description='The textual default description for the deposit machine background system winding in German'),
rvm_winding_descr_de STRING(250) NOT NULL
OPTIONS(description='The textual description for the deposit machine background system winding in German'),
rvm_winding_descr_en STRING(250) NOT NULL
OPTIONS(description='The textual description for the deposit machine background system winding in English'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_winding_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the winding of a reusable background system e.g. straight');