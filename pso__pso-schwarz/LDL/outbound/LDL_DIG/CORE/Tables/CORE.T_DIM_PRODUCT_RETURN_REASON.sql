CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_return_reason (
prod_return_reason_cd STRING(5) NOT NULL
OPTIONS(description='The code for the article return reason on position level  (101, 900, etc)'),
prod_return_reason_descr STRING(250) NOT NULL
OPTIONS(description='The textual description  the article return reason (Artikel defekt, Artikel zu groß/weit, etc)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (prod_return_reason_cd) NOT ENFORCED
)
OPTIONS(description='The minor dimension that describes return reason of returned article on return position level ( 101 - Falsch bestellt, 301-Annahmeverweigerung, etc)');