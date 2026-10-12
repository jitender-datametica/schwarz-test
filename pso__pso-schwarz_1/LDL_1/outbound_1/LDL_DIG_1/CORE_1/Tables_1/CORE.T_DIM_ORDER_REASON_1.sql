CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_order_reason_1 (
order_reason_cd STRING(5) NOT NULL
OPTIONS(description='Order reason code on order document level ( 008 guter Service ,etc)'),
order_reason_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for the order reason code in group language.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (order_reason_cd) NOT ENFORCED
) OPTIONS(description='Order reason code on order document level.');