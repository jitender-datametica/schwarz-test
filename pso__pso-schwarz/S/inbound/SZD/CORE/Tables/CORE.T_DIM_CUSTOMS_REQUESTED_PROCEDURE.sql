/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_REQUESTED_PROCEDURE
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:35:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMS_REQUESTED_PROCEDURE (
   REQUESTED_PROCEDURE_CD              VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of requested procedure.',
   REQUESTED_PROCEDURE_DESCR           VARCHAR(250)    NOT NULL COMMENT 'The name of the type of the requested procedure.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CUSTOMS_REQUESTED_PROCEDURE PRIMARY KEY (REQUESTED_PROCEDURE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Defines the requested procedure codes (the first four characters in a customs procedure code) and ther meaning. - Source - Manual';
