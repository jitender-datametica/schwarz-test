/* --------------------------------------------------------------------------------
   DDL for table: T_TRANSHIPMENT_LOCATION
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TRANSHIPMENT_LOCATION (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the transhipment location.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country where the transhipment location is located in.',
   COUNTRY_POL_CD                      VARCHAR(3)      COMMENT 'The code identifying a political country according to ISO 3166.',
   PORT_PRICE_GROUP_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the price group ',
   TRANSHIPMENT_LOCATION_TYPE_CD       VARCHAR(50)     NOT NULL COMMENT 'The unique code of the transhipment location type.',
   TRANSHIPMENT_LOCATION_CD            VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key - The code of the transhipment location.',
   TRANSHIPMENT_LOCATION_NAME          VARCHAR(100)    COMMENT 'The name of the transhipment location.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'Name of the city in which site is situated',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TRANSHIPMENT_LOCATION PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - At a transhipment location goods are unloaded from one transport vehicle like a ship and loaded into another transport vehicle like a train - Source - Manual';
