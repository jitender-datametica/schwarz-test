CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_dropshipment_sales_order_1 (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier_1 Account_1 Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Product position number on purchase order'),
cust_order_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
cust_order_pos_nr BIGNUMERIC(38,0) OPTIONS(description='The particular position number of an item_1 in an order'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr, supplier_order_pos_nr) NOT ENFORCED
) OPTIONS(description='The etl support table containing the dropshipment sales_1 order details');