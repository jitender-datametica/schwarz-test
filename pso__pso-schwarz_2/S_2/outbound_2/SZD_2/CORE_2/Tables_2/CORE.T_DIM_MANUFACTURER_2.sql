/* --------------------------------------------------------------------------------
   DDL for table: t_dim_manufacturer_2
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:31:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_manufacturer_2 (
manufacturer_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a company which produces deposit machines.'),
manufacturer_group_cd STRING(50) NOT NULL OPTIONS(description='the type of machines, products..a manufacturer produces'),
manufacturer_name STRING(100) NOT NULL OPTIONS(description='The name of a company which produces deposit machines.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (manufacturer_sid) NOT ENFORCED
) OPTIONS(description='A company that produces machines, products e.g..Tomra, Sielaff');