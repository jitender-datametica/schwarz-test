CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_product_availability_level_1 (
avail_lvl_cd STRING(5) NOT NULL
OPTIONS(description='Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)'),
avail_lvl_descr STRING(20) NOT NULL OPTIONS(description='A decription for availability code'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (avail_lvl_cd) NOT ENFORCED
)
OPTIONS(description='Indicator code for availability. In Shop Sys derived from multiple indicators, like stock, expected stock, promotion plan, manual blockers.');