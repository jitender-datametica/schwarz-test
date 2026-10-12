/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_CARRIERLAYER_TRACK_TRACE_1
   GENERATED FROM POWERDESIGNER ON Montag, 4. August 2025 14:01:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_etl_process.t_etl_carrierlayer_track_trace_1 (
pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) for the package_1'),
carrierlayer_event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp of the carrier layer events'),
event_type_name STRING(100) NOT NULL OPTIONS(description='The name of the event type'),
sub_event_type_name STRING(100)
OPTIONS(description='It defines the Sub Event of an event type. e.g. event_type_name  = UNSUCCESSFUL_DELIVERY and sub_event_type_name = DAMAGED'),
pack_order_nr STRING(20) NOT NULL
OPTIONS(description='The order number within warehouse system which tells which articles are part of which package_1'),
pack_tracking_nr STRING(1000) NOT NULL
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
pack_tracking_url STRING(500)
OPTIONS(description='The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer'),
hauler_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for hauler'),
hub_loc_descr STRING(100)
OPTIONS(description='Describes the location_1 of the Hub of a Carrier where the Parcel gets send to / arrives at.'),
orig_carrier_event_cd STRING(100)
OPTIONS(description='Describes a code coming from the carriers which identify what kind of Event it is.'),
pack_size_type_cd STRING(50)
OPTIONS(description='The code for the package_1 size type  (Normal , Überlänge, XXL , Heavy etc)'),
ship_direction_cd STRING(50)
OPTIONS(description='Identifies the direction in which the packets are sent ( Forward / Return )'),
ext_wh_vehicle_nr STRING(40)
OPTIONS(description='This is the number assigned by external warehouses to vehicles which carry the package_1'),
vehicle_license_plate_nr STRING(30)
OPTIONS(description='The licence plate number of the trucks which carries the package_1'),
vehicle_departure_tmsp TIMESTAMP
OPTIONS(description='The timestamp when a truck departed from the warehouse'),
locker_located_at_lidl_store_fg BOOL OPTIONS(description='A flag indicating if locker is situated at Lidl store'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_sid, carrierlayer_event_tmsp, event_type_name, pack_tracking_nr) NOT ENFORCED
) OPTIONS(description='Stores the carrier tracking data');