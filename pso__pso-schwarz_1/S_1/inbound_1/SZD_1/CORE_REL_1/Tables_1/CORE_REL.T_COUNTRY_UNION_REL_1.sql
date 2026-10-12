/* --------------------------------------------------------------------------------
   DDL for table: T_COUNTRY_UNION_REL_1
   generated from Powerdesigner on Donnerstag, 27. Juli 2023 09:35:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_COUNTRY_UNION_REL_1 (
   COUNTRY_UNION_CD                    VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the country_1 union.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the political country.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'An indicator showing the current record in history.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOB storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_COUNTRY_UNION_REL PRIMARY KEY (COUNTRY_UNION_CD, COUNTRY_LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Bridge Table - Defines the membership of political countries in country_1 unions. - Source - Manual';
