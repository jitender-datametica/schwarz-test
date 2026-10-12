/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_DECLARANT_TYPE
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:15:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DECLARANT_TYPE (
   DECLARANT_TYPE_CD                   VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of declarant.',
   DECLARANT_TYPE_NAME                 VARCHAR(100)    NOT NULL COMMENT 'The name of the type of the declarant.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_DECLARANT_TYPE PRIMARY KEY (DECLARANT_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Defines what types of parties can act as declarants to a customs authority. - Source - Manual';
