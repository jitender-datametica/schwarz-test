CREATE TABLE IF NOT EXISTS szd_core.t_dim_rvm_configuration_update_source_1 (
rvm_config_source_cd STRING(50) NOT NULL
OPTIONS(description='The code for the deposit machine configuration source e.g. donwload article meta data 1,...'),
rvm_config_source_descr STRING(250) NOT NULL
OPTIONS(description='A textual default description for the configuration source in German.'),
rvm_config_source_descr_en STRING(250) NOT NULL
OPTIONS(description='A textual description for the configuration source in English.'),
rvm_config_source_descr_de STRING(250) NOT NULL
OPTIONS(description='A textual description for the configuration source in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_config_source_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines the update source system of deposit machines');