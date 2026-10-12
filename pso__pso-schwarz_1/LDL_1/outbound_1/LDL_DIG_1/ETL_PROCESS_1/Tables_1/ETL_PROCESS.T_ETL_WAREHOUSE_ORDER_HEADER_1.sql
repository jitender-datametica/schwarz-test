/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_ORDER_HEADER_1
   GENERATED FROM POWERDESIGNER ON Donnerstag, 13. Juli 2023 11:36:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_order_header_1 (
wshop_cd STRING(5)
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
dist_channel_cd STRING(5)
OPTIONS(description='The code for the distribution channel ( a channel  through which the goods are sold )'),
wh_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for warehouse order'),
wh_order_nr STRING(20) OPTIONS(description='Number uniquely identifying a document of outbound delivery orders'),
wh_order_doc_type_cd STRING(5)
OPTIONS(description='The code for the outbound delivery order document  type  which allows to group outbound delivery orders based on the count of positions and quantities in the order '),
wh_order_create_tmsp TIMESTAMP
OPTIONS(description='The timestamp when the warehouse order was created '),
wh_order_ship_type_name STRING(5)
OPTIONS(description='Type names for deliveries, which have the same type of destination, like e.g. packing stations'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (wh_order_sid) NOT ENFORCED
) OPTIONS(description='ETL  table to support t_fact_warehouse_order_line_1');