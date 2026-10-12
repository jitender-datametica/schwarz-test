/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_CARRIERLAYER_TRACK_TRACE_AUDIT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:21:29
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_CARRIERLAYER_TRACK_TRACE_AUDIT_1 (
   PACK_TRACKING_NR                    VARCHAR(1000)   NOT NULL COMMENT 'The tracking ID which links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url',
   HAULER_SID                          NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for hauler',
   CARRIERLAYER_EVENT_TMSP             TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp of the carrier layer events',
   EVENT_TYPE_NAME                     VARCHAR(100)    NOT NULL COMMENT 'The name of the event type',
   HAULER_NAME                         VARCHAR(100)    COMMENT 'The name by which hauler is known',
   HAULER_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country_1 according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France',
   PACK_SID                            NUMBER          COMMENT 'The unique identifier(surrogate key) for the package_1',
   PACK_ORDER_NR                       VARCHAR(20)     COMMENT 'The order number within warehouse system which tells which articles are part of which package_1',
   PACK_TRACKING_URL                   VARCHAR(500)    COMMENT 'The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_FACT_CARRIERLAYER_TRACK_TRACE_AUDIT PRIMARY KEY (HAULER_SID, PACK_TRACKING_NR, CARRIERLAYER_EVENT_TMSP, EVENT_TYPE_NAME) NOT ENFORCED 
)  COMMENT = 'Stores the carrier tracking data for audit';
