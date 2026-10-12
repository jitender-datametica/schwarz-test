/*
    CREATE T_REL_SOURCE_TABLE_VALUE_POSITION
*/


CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_rel_source_table_value_position (
source_table STRING(100) NOT NULL
OPTIONS(description='Name of the table that is the source of the value cube position.'),
field_name STRING(50) NOT NULL
OPTIONS(description='It is the name of the field in the corresponding source table (eg. PROD_QTY or PACK_QTY).'),
value_pos_cd STRING(10)
OPTIONS(description='Identifier of the value cube position. Each metric can be a value cube position.'),
tmsp_insert TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (source_table, field_name) NOT ENFORCED
)
OPTIONS(description='The relational table holding the name of the source table and of the field associated to the value cube position.');