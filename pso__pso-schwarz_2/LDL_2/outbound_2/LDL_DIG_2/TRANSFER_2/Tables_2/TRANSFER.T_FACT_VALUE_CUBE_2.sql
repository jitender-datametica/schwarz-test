/*
    CREATE T_FACT_VALUE_CUBE_2
*/


CREATE TABLE IF NOT EXISTS ldl_dig_transfer.t_fact_value_cube_2 (
vc_pk_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a particular value cube record.'),
value_pos_cd STRING(10) NOT NULL
OPTIONS(description='Identifier of the value cube position. Each metric can be a value cube position.'),
value_amount BIGNUMERIC(38,5)
OPTIONS(description='The amount corresponding to the value cube record and the value cube position combination.'),
tmsp_insert TIMESTAMP
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
tmsp_update TIMESTAMP OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (vc_pk_sid, value_pos_cd) NOT ENFORCED
)
OPTIONS(description='The fact table holding the details such as the position codes and corresponding value amount for value cube record positions.');