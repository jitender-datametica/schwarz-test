CREATE OR REPLACE TABLE szd_production_core.t_dim_rvm_type_2 (
rvm_type_cd STRING(50) NOT NULL
OPTIONS(description='The code by which this type of deposit machine is identied, as assigned by the manufacturer.'),
manufacturer_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
rvm_type_name STRING(100) NOT NULL
OPTIONS(description='The code by which this type of deposit machine is identied, as assigned by the manufacturer.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (rvm_type_cd, manufacturer_sid) NOT ENFORCED
) OPTIONS(description='This minor entity defines the types of deposit machines offered by each manufacturer.');