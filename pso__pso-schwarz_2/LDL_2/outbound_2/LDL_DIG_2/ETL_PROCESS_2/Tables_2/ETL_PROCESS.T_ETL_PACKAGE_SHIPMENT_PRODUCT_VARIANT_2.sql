/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_PACKAGE_SHIPMENT_PRODUCT_VARIANT_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:02
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_package_shipment_product_variant_2 (
pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for the package_2'),
prod_variant_sid BIGNUMERIC NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product variant of the returned product'),
pack_tracking_nr STRING(1000)
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url'),
sale_order_sid BIGNUMERIC
OPTIONS(description='The unique identifier  for the sales_2 order ( can be customer or intercompany order)'),
sale_order_nr STRING(20) OPTIONS(description='The original order number of the source system'),
sale_order_pos_nr BIGNUMERIC OPTIONS(description='The particular position number of an item_2 in an order'),
prod_qty BIGNUMERIC(38,5) OPTIONS(description='Quantity of a particular product returned.'),
additional_services_desc STRING(1000)
OPTIONS(description='Text describing additional characteristics of delivery service. '),
delivery_to_point_of_use_fg BOOL
OPTIONS(description='Flag indicating if the product will be delivered to the point of use.'),
delivery_pick_up_for_recycling_fg BOOL
OPTIONS(description='Flag that the old device will be picked up with the delivery of the new'),
delivery_label_for_recycling_fg BOOL
OPTIONS(description='Flag indicating that the customer will send the old device with a label. No pick-up.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_sid, prod_variant_sid) NOT ENFORCED
)
OPTIONS(description='Stores information provided by carrier for forward shipments at the level of  Product Variant per Package_2');