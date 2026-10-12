/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_MARITIME_PORT
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_MARITIME_PORT (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the port.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   PORT_PRICE_GROUP_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the price group ',
   PORT_NAME                           VARCHAR(100)    NOT NULL COMMENT 'Natural Key/Business Key - The name of the port.',
   PORT_SHORT_NAME                     VARCHAR(100)    COMMENT 'Descriptive Attribute - Short name of which the port is known.',
   CITY_NAME                           VARCHAR(100)    COMMENT 'Descriptive Attribute - Name of the city in which site is situated',
   SHORT_NAME_BUSINESS_CD              VARCHAR(50)     NOT NULL COMMENT 'Derived attribute - Combined country_pol_cd and short name as known by business',
   COUNTRY_POL_CD                      VARCHAR(3)      NOT NULL COMMENT 'The code identifying a political country according to ISO 3166.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_MARITIME_PORT PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - A port is a maritime facility comprising one or more wharves or loading areas, where ships load and discharge cargo. - Source - VMT';
