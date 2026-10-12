/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_UNION_1
   generated from Powerdesigner on Donnerstag, 27. Juli 2023 09:23:06
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COUNTRY_UNION_1 (
   COUNTRY_UNION_CD                    VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the country_1 union.',
   COUNTRY_UNION_NAME                  VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The name of the country_1 union.',
   COUNTRY_UNION_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - A brief description of the country_1 union.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_COUNTRY_UNION PRIMARY KEY (COUNTRY_UNION_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - A union of countries is an association of different sovereign states for the purpose of close cooperation. - Source - Manual';
