/*
    CREATE T_REL_VALUE_CUBE_DOMAIN_HIERARCHY_2
*/


CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_rel_value_cube_domain_hierarchy_2 (
data_domain_cd STRING(50) NOT NULL
OPTIONS(description='Identifier code for data domains (eg. department name can be a data domain).'),
cube_level_type_cd STRING(50) NOT NULL
OPTIONS(description='Identifier for the level type of value cube (eg. order, product, customer).'),
cube_descr STRING(150) OPTIONS(description='Description of the value cube.'),
value_pos_cd STRING(10) NOT NULL
OPTIONS(description='Identifier of the value cube position. Each metric can be a value cube position.'),
value_pos_descr STRING(150) OPTIONS(description='Description of the value cube position.'),
agg_value_logic STRING(350) OPTIONS(description='Logic describing the aggregation for subtotals and totals.'),
factor_sign BIGNUMERIC(38,0) OPTIONS(description='A BYTES indicator defining the multiplicative factor as +1 or -1.'),
display_order_nr BIGNUMERIC(38,0) OPTIONS(description='Numbers displaying the visual sequential order.'),
tmsp_insert TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (data_domain_cd, cube_level_type_cd, value_pos_cd) NOT ENFORCED
) OPTIONS(description='The relational table holding the logic needed to define the value cubes output.');