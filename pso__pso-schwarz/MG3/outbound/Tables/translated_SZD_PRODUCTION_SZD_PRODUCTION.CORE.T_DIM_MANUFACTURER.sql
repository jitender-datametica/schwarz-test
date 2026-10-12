CREATE OR REPLACE TABLE szd_production_core.t_dim_manufacturer (
manufacturer_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
manufacturer_group_cd STRING(50) NOT NULL OPTIONS(description='the type of machines, products..a manufacturer produces'),
manufacturer_name STRING(100) NOT NULL OPTIONS(description='The name of a company which produces deposit machines.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (manufacturer_sid) NOT ENFORCED
) OPTIONS(description='A company that produces machines, products e.g..Tomra, Sielaff');