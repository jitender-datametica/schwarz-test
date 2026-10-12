/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_ETL_RETURN_PACKAGE_SHIPMENT_EVENT_2
   GENERATED FROM POWERDESIGNER ON Mittwoch, 4. September 2024 14:26:34
*/ --------------------------------------------------------------------------------

CREATE TABLE ETL_PROCESS.T_ETL_RETURN_PACKAGE_SHIPMENT_EVENT_2 (
   RETURN_PACK_SID                     NUMBER          NOT NULL COMMENT 'The unique identifier(surrogate key) for the return package_2',
   EVENT_TYPE_NAME                     VARCHAR(100)    NOT NULL COMMENT 'The name of the event type',
   CARRIERLAYER_EVENT_TMSP             TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp of the carrier layer events',
   RETURN_REQUEST_NR                   VARCHAR(50)     COMMENT 'Internal return request number, created by Lidl when a customer creates a return request.  Not every return request is turned into return order.',
   RETURN_PACK_TRACKING_NR             VARCHAR(1000)   COMMENT 'ID, which links the shipment of the return (from customer to Lidl Digital) with the actual package_2 and can also be searched for within the the carrier url',
   RETURN_PACK_TRACKING_URL            VARCHAR(500)    COMMENT 'URL to track the return package_2 shipment',
   HAULER_SID                          NUMBER          COMMENT 'The unique identifier (surrogate key) for hauler',
   ORIGIN_COUNTRY_CD                   VARCHAR(5)      COMMENT 'The unique code for a country_2 from which the customer sends back the package_2(s) (according to ISO-3166 Alpha-2. E.g. \"DE\" for Germany or \"FR\" for France)',
   RETURN_WH_SID                       NUMBER          COMMENT 'The unique identifier (surrogate key) for the warehouse handling the return.',
   RETURN_OPTION_CD                    VARCHAR(50)     COMMENT 'Return option of the shipment, it can be LABEL or PICK_UP.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_T_ETL_RETURN_PACKAGE_SHIPMENT_EVENT PRIMARY KEY (RETURN_PACK_SID, CARRIERLAYER_EVENT_TMSP, EVENT_TYPE_NAME) NOT ENFORCED 
)  COMMENT = 'Stores the return package_2 shipment event data.';
