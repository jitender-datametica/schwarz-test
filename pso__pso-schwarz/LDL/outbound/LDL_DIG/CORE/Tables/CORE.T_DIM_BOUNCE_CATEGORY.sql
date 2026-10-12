CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_bounce_category (
bounce_category_id BIGNUMERIC NOT NULL
OPTIONS(description='The numeric identifier to uniquely identify the bounce categories'),
bounce_category_name STRING(100) NOT NULL OPTIONS(description='The name of the bounce category type (e.g. soft, block)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (bounce_category_id) NOT ENFORCED
)
OPTIONS(description='This dimension holds the different bounce categories based on the reason the email bounced (e.g. soft bounce)');