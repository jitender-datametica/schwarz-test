/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RETURN_PACKAGE_SHIPMENT_PRODUCT_VARIANT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:55
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_return_package_shipment_product_variant_1 (
return_pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for the return package_1'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant of the returned product'),
return_request_nr STRING(50)
OPTIONS(description='Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.'),
return_pack_tracking_nr STRING(1000)
OPTIONS(description='ID, which links the shipment of the return (from customer to Lidl Digital) with the actual package_1 and can also be searched for within the the carrier url'),
sale_order_sid BIGNUMERIC
OPTIONS(description='The unique identifier  for the sales_1 order ( can be customer or intercompany order)'),
sale_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
sale_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_1 in an order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product returned.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (return_pack_sid, prod_variant_sid) NOT ENFORCED
) OPTIONS(description='Stores the return package_1 shipment product variant data.');