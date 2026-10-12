/* --------------------------------------------------------------------------------
   DDL for table: T_EXTERNAL_WAREHOUSE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_EXTERNAL_WAREHOUSE_2 (
   RESOURCE_ITEM_SID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the political country.',
   COUNTRY_POL_CD                      VARCHAR(3)      NOT NULL COMMENT 'The code identifying a political country_2 according to ISO 3166.',
   WAREHOUSE_NAME                      VARCHAR(100)    COMMENT 'Descriptive Attribute - The name of the warehouse.',
   WAREHOUSE_SHORT_NAME                VARCHAR(100)    COMMENT 'Descriptive Attribute - Short name by which the warehouse is known.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'Descriptive Attribute - Name of the city in which warehouse is situated',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_EXTERNAL_WAREHOUSE PRIMARY KEY (RESOURCE_ITEM_SID, DWH_VALID_TO_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A  warehouse in the harbour used to unload and store goods. Source - VMT';
