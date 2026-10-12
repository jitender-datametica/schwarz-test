/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_CARRIERLAYER_TRACK_TRACE
   GENERATED FROM POWERDESIGNER ON Montag, 4. August 2025 14:01:44
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_CARRIERLAYER_TRACK_TRACE (
   PACK_SID                            NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) for the package',
   CARRIERLAYER_EVENT_TMSP             TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp of the carrier layer events',
   EVENT_TYPE_NAME                     VARCHAR(100)    NOT NULL COMMENT 'The name of the event type',
   SUB_EVENT_TYPE_NAME                 VARCHAR(100)    COMMENT 'It defines the Sub Event of an event type. e.g. event_type_name  = UNSUCCESSFUL_DELIVERY and sub_event_type_name = DAMAGED',
   PACK_ORDER_NR                       VARCHAR(20)     NOT NULL COMMENT 'The order number within warehouse system which tells which articles are part of which package',
   PACK_TRACKING_NR                    VARCHAR(1000)   NOT NULL COMMENT 'The tracking ID which links the shipment to customer with the actual package and can also be searched for within the the carrier url',
   PACK_TRACKING_URL                   VARCHAR(500)    COMMENT 'The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   HUB_LOC_DESCR                       VARCHAR(100)    COMMENT 'Describes the location of the Hub of a Carrier where the Parcel gets send to / arrives at.',
   ORIG_CARRIER_EVENT_CD               VARCHAR(100)    COMMENT 'Describes a code coming from the carriers which identify what kind of Event it is.',
   PACK_SIZE_TYPE_CD                   VARCHAR(50)     COMMENT 'The code for the package size type  (Normal , Überlänge, XXL , Heavy etc)',
   SHIP_DIRECTION_CD                   VARCHAR(50)     COMMENT 'Identifies the direction in which the packets are sent ( Forward / Return )',
   EXT_WH_VEHICLE_NR                   VARCHAR(40)     COMMENT 'This is the number assigned by external warehouses to vehicles which carry the package',
   VEHICLE_LICENSE_PLATE_NR            VARCHAR(30)     COMMENT 'The licence plate number of the trucks which carries the package',
   VEHICLE_DEPARTURE_TMSP              TIMESTAMP_TZ(9) COMMENT 'The timestamp when a truck departed from the warehouse',
   LOCKER_LOCATED_AT_LIDL_STORE_FG     BOOLEAN         COMMENT 'A flag indicating if locker is situated at Lidl store',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_CARRIERLAYER_TRACK_TRACE PRIMARY KEY (PACK_SID, CARRIERLAYER_EVENT_TMSP, EVENT_TYPE_NAME, PACK_TRACKING_NR) NOT ENFORCED 
)  COMMENT = 'Stores the carrier tracking data';
