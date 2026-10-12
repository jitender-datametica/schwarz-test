/* --------------------------------------------------------------------------------
   DDL for table: t_dim_manufacturer_group_2
   generated from Powerdesigner on Donnerstag, 13. Oktober 2022 15:30:25
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_manufacturer_group_2 (
manufacturer_group_cd STRING(50) NOT NULL OPTIONS(description='the type of machines, products..a manufacturer produces'),
manufacturer_group_name STRING(100) NOT NULL OPTIONS(description='The group name of manufacturers Productions'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (manufacturer_group_cd) NOT ENFORCED
) OPTIONS(description='This minor dimension defines Manufactrurer groups for which they produce machines e.g. RVM, HGA');