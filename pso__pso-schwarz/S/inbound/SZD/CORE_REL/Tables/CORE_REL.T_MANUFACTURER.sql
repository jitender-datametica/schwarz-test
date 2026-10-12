/* --------------------------------------------------------------------------------
   DDL for table: T_MANUFACTURER
   generated from Powerdesigner on Dienstag, 14. November 2023 09:26:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_MANUFACTURER (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   MANUFACTURER_GROUP_CODE             VARCHAR(50)     NOT NULL COMMENT 'The code for the classification group of manufacturers based on the type of machines they produce ',
   MANUFACTURER_NAME                   VARCHAR(100)    COMMENT 'The name of a company which produces the machines.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_MANUFACTURER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - Manufacturer, the company that produces machines, products and other goods (e.g..Tomra, Sielaff)';
