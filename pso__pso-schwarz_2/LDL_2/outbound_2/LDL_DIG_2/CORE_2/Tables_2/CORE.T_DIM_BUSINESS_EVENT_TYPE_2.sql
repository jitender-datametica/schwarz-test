/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_BUSINESS_EVENT_TYPE_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 29. Juni 2022 13:34:37
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_business_event_type_2 (
business_event_type_cd STRING(5) NOT NULL
OPTIONS(description='Code identifying the retail business event type  ( ex. O = Order, R = return ...)'),
business_event_type_descr STRING(250)
OPTIONS(description='Textual description of the event type that leads to profit or loss'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
src_file_tmsp TIMESTAMP
OPTIONS(description='The point in time when this record was extracted from the source.'),
dwh_src_file_name STRING(255)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
PRIMARY KEY (business_event_type_cd) NOT ENFORCED
) OPTIONS(description='A minor dimension that contains type of events in the retail business ( "Order" , "Return") ');