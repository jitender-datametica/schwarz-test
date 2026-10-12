CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_address_type_1 (
addr_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the address_1 type. Possible values: OS (=OnlineShop) & TR (=Travel). '),
addr_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the address_1 type in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (addr_type_cd) NOT ENFORCED
)
OPTIONS(description='The differentiator from which business area the address_1 comes from. Possible values: OS (=OnlineShop) & TR (=Travel). Equivalent to the cust_type_cd within the table t_dim_customer_1');