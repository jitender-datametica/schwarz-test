CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_touchpoint_level1_2 (
cust_touchpoint_lvl1_id BIGNUMERIC NOT NULL
OPTIONS(description='The identifier for customer touchpoint at highest level-lvl1'),
cust_touchpoint_lvl1_name STRING(100) NOT NULL
OPTIONS(description='The textual name for customer touchpoint at highest level-lvl1'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_touchpoint_lvl1_id) NOT ENFORCED
)
OPTIONS(description='This dimension defines different customer touchpoints by its highest hierarchy_2 (e.g. - Online, Offline)');