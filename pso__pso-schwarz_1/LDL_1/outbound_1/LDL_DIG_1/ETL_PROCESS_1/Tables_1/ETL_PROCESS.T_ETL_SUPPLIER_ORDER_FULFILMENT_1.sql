/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_SUPPLIER_ORDER_FULFILMENT_1
   GENERATED FROM POWERDESIGNER ON Dienstag, 13. Dezember 2022 11:33:40
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_supplier_order_fulfilment_1 (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier_1 Order Number present in the Purchase Order'),
supplier_order_pos_nr BIGNUMERIC NOT NULL OPTIONS(description='Product position number on purchase order'),
vendor_confirmation_nr BIGNUMERIC NOT NULL OPTIONS(description='Idenfier of the vendor confirmation'),
supplier_order_fulfilment_dt DATE
OPTIONS(description='On this date the supplier_1 confirmed that it will provide this product qunatity'),
delivery_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
delivery_order_nr STRING(20) OPTIONS(description='Delivery order number '),
delivery_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of a position in an order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of the product that is confirmed will be delivered'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr, supplier_order_pos_nr, vendor_confirmation_nr) NOT ENFORCED
)
OPTIONS(description='The ETL support table holding the order position details placed by Lidl purchase department ( DE ) from a supplier_1 ');