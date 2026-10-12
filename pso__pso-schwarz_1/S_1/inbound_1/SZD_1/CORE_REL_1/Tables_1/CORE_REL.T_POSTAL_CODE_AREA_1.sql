/* --------------------------------------------------------------------------------
   DDL for table: T_POSTAL_CODE_AREA_1
   generated from Powerdesigner on Donnerstag, 24. Oktober 2024 14:05:37
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_POSTAL_CODE_AREA_1 (
   LOCATION_SID                        NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the location.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   COUNTRY_LOCATION_SID                NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country_1 location.',
   ZIP                                 VARCHAR(15)     NOT NULL COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_POSTAL_CODE_AREA PRIMARY KEY (LOCATION_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - The geographical area which is identified by a zip code.';
