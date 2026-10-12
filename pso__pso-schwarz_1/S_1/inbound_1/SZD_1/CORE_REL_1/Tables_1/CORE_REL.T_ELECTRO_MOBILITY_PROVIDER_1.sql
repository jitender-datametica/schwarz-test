/* --------------------------------------------------------------------------------
   DDL for table: T_ELECTRO_MOBILITY_PROVIDER_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 11:16:53
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_ELECTRO_MOBILITY_PROVIDER_1 (
   PARTY_SID                           NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   EMP_NAME                            VARCHAR(100)    NOT NULL COMMENT 'Natural/Business Key - The name of the electro mobility provider.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_T_ELECTRO_MOBILITY_PROVIDER PRIMARY KEY (PARTY_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED 
)  COMMENT = 'Major Entity - A company which offers an EV (Electric Vehicle) charging service to the drivers. It enables access to a large pool of charging points around a geographic area. - Source - IOTCharger';
