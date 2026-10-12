/* --------------------------------------------------------------------------------
   DDL for table: T_STREET_ADDRESS_1
   generated from Powerdesigner on Donnerstag, 24. Oktober 2024 10:55:07
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_STREET_ADDRESS_1 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 location.',
   CITY_LOCATION_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   POSTAL_CODE_AREA_LOCATION_SID       NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   STREET_NAME                         VARCHAR(100)    COMMENT 'The name of the street, in which this address_1 is located. (This includes names of squares and similar locations.)',
   HOUSE_NR                            VARCHAR(50)     COMMENT 'The number of a house in a street.',
   LONGITUDE                           NUMBER(9, 6)    COMMENT 'The longitude component of the geographical coordinates of this address.',
   LATITUDE                            NUMBER(9, 6)    COMMENT 'The latitude component of the geographical coordinates of this address.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_STREET_ADDRESS PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A physical mailing address_1, typically consisting of a street name, a house number, a city or village with a zip code and (optionally) a country.';
