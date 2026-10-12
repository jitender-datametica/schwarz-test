/* --------------------------------------------------------------------------------
   DDL for table: T_CUSTOMS_OFFICE_1
   generated from Powerdesigner on Dienstag, 11. Juli 2023 14:30:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CUSTOMS_OFFICE_1 (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the customs office.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   AUTHORITY_COUNTRY_LOCATION_SID      NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - The unique identifier (surrogate key) for the country_1 where the customs office is located.',
   CUSTOMS_OFFICE_CD                   VARCHAR(250)    NOT NULL COMMENT 'Natural Key/Business Key - The unique code that identifies the customs office within the country.',
   CUSTOMS_OFFICE_NAME                 VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The name of the customs office.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_CUSTOMS_OFFICE PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A customs office is a department of a customs authority for the regulation of customs matters. - Source - Manual';
