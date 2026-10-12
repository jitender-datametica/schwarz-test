CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_touchpoint_level3 (
cust_touchpoint_lvl3_id BIGNUMERIC NOT NULL
OPTIONS(description='The identifier for customer touchpoint at hierarchy level 3'),
cust_touchpoint_lvl2_id BIGNUMERIC OPTIONS(description='The identifier for customer touchpoint at hierarchy level 2'),
cust_touchpoint_lvl3_name STRING(100) NOT NULL
OPTIONS(description='The textual name for customer touchpoint at hierarchy level 3'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_touchpoint_lvl3_id) NOT ENFORCED
)
OPTIONS(description='This dimension defines different customer touchpoints by its hierarchy level3(e.g. - Print Magazine, Mailings)');