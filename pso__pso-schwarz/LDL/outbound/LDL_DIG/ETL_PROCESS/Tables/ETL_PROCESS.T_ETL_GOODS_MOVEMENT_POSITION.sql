/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_GOODS_MOVEMENT_POSITION
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:35:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_goods_movement_position (
delivery_order_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_nr STRING(20) NOT NULL OPTIONS(description='Delivery order number '),
delivery_order_pos_nr BIGNUMERIC NOT NULL
OPTIONS(description='The particular position number of a position in an order'),
prod_variant_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
delivery_prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of products to be delivered'),
cust_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for customer order'),
cust_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item in an order'),
cust_order_return_nr STRING(20) OPTIONS(description='An original return order number'),
cust_order_return_pos_nr BIGNUMERIC
OPTIONS(description='A number of an particular position ( product ) in an return order'),
storage_loc_cd STRING(10) OPTIONS(description='The code which identifies the storage location (10001, 1002, etc)'),
sale_doc_type_cd STRING(5)
OPTIONS(description='The code for the the delivery document ( C (Order), H (Return), I (Order w/o charge), V (Purchase Order) )'),
order_item_category_cd STRING(5) OPTIONS(description='The code to uniquely identify the order item categories'),
dropshipment_order_fg BOOL
OPTIONS(description='In case the material is being sent from the supplier this field will be filled.'),
supplier_order_nr STRING(20) OPTIONS(description='Supplier Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC OPTIONS(description='Product position number on purchase order'),
wh_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (delivery_order_sid, delivery_order_pos_nr) NOT ENFORCED
) OPTIONS(description='The etl support table for goods movement position fact');