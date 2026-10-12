CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_order_return_reason_1 (
order_return_reason_cd STRING(5) NOT NULL
OPTIONS(description='The code for the reason code on return document level .( 401 - Leeres Paket, 104 - Artikel_1 unvollständig , etc)'),
order_return_reason_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for the sales_1 channel in group language.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (order_return_reason_cd) NOT ENFORCED
)
OPTIONS(description='Return reason code on return document level. Available for full and partial returns.( 401 - Leeres Paket, 104 - Artikel_1 unvollständig , etc)');