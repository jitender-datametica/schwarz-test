/* --------------------------------------------------------------------------------
   DDL for table: T_REAL_ESTATE
   generated from Powerdesigner on Montag, 13. November 2023 11:17:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REAL_ESTATE (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the resource item.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   STREET_ADDRESS_LOCATION_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the political country.',
   DIVISION_PARTY_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party as a division. Key generation based on META table for party key space.',
   REAL_ESTATE_NR                      VARCHAR(250)    NOT NULL COMMENT 'The unique code of the real estate within the country.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_REAL_ESTATE PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A real estate is a non-movable building such as a store or a parking garage. - Source - IOTCharger';
