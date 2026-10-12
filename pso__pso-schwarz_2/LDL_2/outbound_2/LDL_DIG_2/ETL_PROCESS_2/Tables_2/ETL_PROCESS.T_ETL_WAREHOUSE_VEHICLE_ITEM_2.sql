/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_WAREHOUSE_VEHICLE_ITEM_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:27:26
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_warehouse_vehicle_item_2 (
wh_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the warehouse'),
vehicle_internal_nr STRING(40) NOT NULL
OPTIONS(description='This number is the internal number of the trucks which carries the package.'),
delivery_order_nr STRING(20) NOT NULL
OPTIONS(description='The order number from the SAP retail system that processes deliveries'),
pack_tracking_nr STRING(1000) NOT NULL
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_2 and can also be searched for within the the carrier url'),
wh_cd STRING(5) OPTIONS(description='A short  unique code for warehouse'),
delivery_order_sid BIGNUMERIC(38,0) OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (wh_sid, vehicle_internal_nr, delivery_order_nr, pack_tracking_nr) NOT ENFORCED
) OPTIONS(description='An ETL table intended for loading core.t_fact_customer_package_shipment');