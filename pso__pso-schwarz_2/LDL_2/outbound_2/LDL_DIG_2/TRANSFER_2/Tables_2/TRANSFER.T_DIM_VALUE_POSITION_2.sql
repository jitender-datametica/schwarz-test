/*
    CREATE T_DIM_CUBE_VALUE_POSITION
*/


CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_dim_value_position_2 (
value_pos_cd STRING(10) NOT NULL
OPTIONS(description='Identifier of the value cube position. Each metric can be a value cube position.'),
value_pos_name_en STRING(50) OPTIONS(description='English name of the position eg. product quantity.'),
value_pos_name_de STRING(50) OPTIONS(description='German name of the position eg. Bestellmenge.'),
amount_type_cd STRING(5)
OPTIONS(description='This field helps identify what type of value is this position eg. value or quantity.'),
unit_type_cd STRING(5)
OPTIONS(description='Describe different units (eg. quantity, currency) associated to the value cube position.'),
tmsp_insert TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (value_pos_cd) NOT ENFORCED
)
OPTIONS(description='A minor dimension that, contains one row for each value position that can be found in the value cube.');