/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_BUSINESS_GROUP_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COUNTRY_BUSINESS_GROUP_2 (
   LOCATION_GROUP_SID                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location_2 group. Key generation based on META table for party key space.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   COUNTRY_BUSINESS_GROUP_CD           VARCHAR(50)     NOT NULL COMMENT 'Natural/Business Key -  identifying the country_2 group',
   COUNTRY_BUSINESS_GROUP_NAME         VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - the name of the country_2 group',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_COUNTRY_BUSINESS_GROUP PRIMARY KEY (LOCATION_GROUP_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A group/cluster of geopolitical countries (with a sovereign governing e.g. Germany, France, UK, ...) built for reasons of licencing costs or delivery & governance synnergies. Source - manually filled';
