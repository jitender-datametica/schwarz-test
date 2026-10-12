/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RETURN_PACKAGE_SHIPMENT_EVENT
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:34
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_return_package_shipment_event (
return_pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for the return package'),
event_type_name STRING(100) NOT NULL OPTIONS(description='The name of the event type'),
carrierlayer_event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp of the carrier layer events'),
return_request_nr STRING(50)
OPTIONS(description='Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.'),
return_pack_tracking_nr STRING(1000)
OPTIONS(description='ID, which links the shipment of the return (from customer to Lidl Digital) with the actual package and can also be searched for within the the carrier url'),
return_pack_tracking_url STRING(500) OPTIONS(description='URL to track the return package shipment'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for hauler'),
origin_country_cd STRING(5)
OPTIONS(description='The unique code for a country from which the customer sends back the package(s) (according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France)'),
return_wh_sid BIGNUMERIC
OPTIONS(description='The unique identifier (surrogate key) for the warehouse handling the return.'),
return_option_cd STRING(50) OPTIONS(description='Return option of the shipment, it can be LABEL or PICK_UP.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (return_pack_sid, carrierlayer_event_tmsp, event_type_name) NOT ENFORCED
) OPTIONS(description='Stores the return package shipment event data.');