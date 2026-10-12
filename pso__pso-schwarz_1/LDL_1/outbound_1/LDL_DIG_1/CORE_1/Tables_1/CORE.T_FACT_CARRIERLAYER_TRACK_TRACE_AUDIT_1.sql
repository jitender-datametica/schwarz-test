/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CARRIERLAYER_TRACK_TRACE_AUDIT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:21:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_carrierlayer_track_trace_audit_1 (
pack_tracking_nr STRING(1000) NOT NULL
OPTIONS(description='The tracking ID which links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for hauler'),
carrierlayer_event_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The timestamp of the carrier layer events'),
event_type_name STRING(100) NOT NULL OPTIONS(description='The name of the event type'),
hauler_name STRING(100) OPTIONS(description='The name by which hauler is known'),
hauler_country_cd STRING(5)
OPTIONS(description='The unique code for a country_1 according to ISO-3166 Alpha-2. E.g.\"DE\" for Germany or\"FR\" for France'),
pack_sid BIGNUMERIC OPTIONS(description='The unique identifier(surrogate key) for the package_1'),
pack_order_nr STRING(20)
OPTIONS(description='The order number within warehouse system which tells which articles are part of which package_1'),
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
PRIMARY KEY (hauler_sid, pack_tracking_nr, carrierlayer_event_tmsp, event_type_name) NOT ENFORCED
) OPTIONS(description='Stores the carrier tracking data for audit');