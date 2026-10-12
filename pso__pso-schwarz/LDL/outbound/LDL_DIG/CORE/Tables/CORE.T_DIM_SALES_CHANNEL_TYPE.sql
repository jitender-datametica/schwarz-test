CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_sales_channel_type (
sales_channel_type_cd STRING(5) NOT NULL
OPTIONS(description='The code for the device which was being used to order from the online webshop.Possible values are desktop browser, iOS or Android.'),
sales_channel_type_descr STRING(250) NOT NULL
OPTIONS(description='The textual description for the sales channel in group language.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (sales_channel_type_cd) NOT ENFORCED
)
OPTIONS(description='This minor dimension defines the type of sales channel device via which order was made ( Iphone , Web... )');