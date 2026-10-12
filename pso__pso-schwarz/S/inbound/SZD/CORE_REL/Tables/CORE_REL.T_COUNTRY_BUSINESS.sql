/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_BUSINESS
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COUNTRY_BUSINESS (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   COUNTRY_GROUP_LOCATION_GROUP_SID    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location group',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   COUNTRY_BUSINESS_CD                 VARCHAR(3)      NOT NULL COMMENT 'Natural/Business Key - The code identifying the country according in the SCHWARZ group',
   COUNTRY_BUSINESS_ISO3166_2_CD       VARCHAR(3)      NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country according to ISO 3166_2',
   COUNTRY_BUSINESS_ISO3166_3_CD       VARCHAR(3)      NOT NULL COMMENT 'Descriptive Attribute - The code identifying the country according to ISO 3166_3',
   COUNTRY_BUSINESS_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name by which the country is known,',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_COUNTRY_BUSINESS PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A SCHWARZ group country used for internal usage. SCHWARZ group country is different from common political country entity e.g. it contains INT as country definition. Source - IT4You Service Now';
