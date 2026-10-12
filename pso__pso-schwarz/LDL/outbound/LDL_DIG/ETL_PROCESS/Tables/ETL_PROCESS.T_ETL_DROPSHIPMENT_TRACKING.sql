/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_DROPSHIPMENT_TRACKING
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:25:28
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_dropshipment_tracking (
supplier_order_nr STRING(20) NOT NULL OPTIONS(description='Supplier Order Number present in the Purchase Order'),
pack_tracking_nr STRING(1000) NOT NULL
OPTIONS(description='ID, whcih links the shipment to customer with the actual package and can also be searched for within the the carrier url'),
pack_tracking_url STRING(500)
OPTIONS(description='The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (supplier_order_nr, pack_tracking_nr) NOT ENFORCED
) OPTIONS(description='The etl table to support tracking of dropshipment orders');