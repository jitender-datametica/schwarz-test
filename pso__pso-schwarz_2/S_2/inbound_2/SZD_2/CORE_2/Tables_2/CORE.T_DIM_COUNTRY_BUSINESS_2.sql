/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_COUNTRY_BUSINESS_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:13
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_COUNTRY_BUSINESS_2 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   COUNTRY_BUSINESS_GROUP_LOCATION_GROUP_SID NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location_2 group',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   COUNTRY_BUSINESS_CD                 VARCHAR(3)      NOT NULL COMMENT 'The code identifying the country_2 according in the SCHWARZ group',
   COUNTRY_BUSINESS_ISO3166_2_CD       VARCHAR(3)      NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country_2 according to ISO 3166_2',
   COUNTRY_BUSINESS_ISO3166_3_CD       VARCHAR(3)      NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country_2 according to ISO 3166_3',
   COUNTRY_BUSINESS_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name by which the country_2 is known,',
   COUNTRY_BUSINESS_GROUP_CD           VARCHAR(50)     NOT NULL COMMENT 'Denormalized Attribute - Natural/Business Key -  identifying the country_2 group',
   COUNTRY_BUSINESS_GROUP_NAME         VARCHAR(100)    NOT NULL COMMENT 'Denormalized Descriptive Attribute - the name of the country_2 group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_COUNTRY_BUSINESS PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Dimension - A SCHWARZ group country_2 used for internal usage. SCHWARZ group country_2 is different from common political country_2 entity e.g. it contains INT as country_2 definition. Source - IT4You Service Now';
