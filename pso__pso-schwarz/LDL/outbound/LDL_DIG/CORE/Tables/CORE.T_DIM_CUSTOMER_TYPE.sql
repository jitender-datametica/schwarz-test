CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_customer_type (
cust_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the customer type. Possible values: OS (=OnlineShop) & TR (=Travel). '),
cust_type_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the customer  type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (cust_type_cd) NOT ENFORCED
)
OPTIONS(description='The differentiator from which business area the customer comes from. Possible values: OS (=OnlineShop) & TR (=Travel). Equivalent to the addr_type_cd within the table t_dim_address');