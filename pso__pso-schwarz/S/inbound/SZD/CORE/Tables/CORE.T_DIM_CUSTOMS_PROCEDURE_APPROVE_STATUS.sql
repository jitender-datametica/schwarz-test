/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_PROCEDURE_APPROVE_STATUS
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:41:00
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMS_PROCEDURE_APPROVE_STATUS (
   CUSTOMS_PROCEDURE_APPROVE_STATUS_CD VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the type of customs procedure approval status.',
   CUSTOMS_PROCEDURE_APPROVE_STATUS_NAME VARCHAR(250)    NOT NULL COMMENT 'The name of the type of the customs procedure approval status.',
   CUSTOMS_PROCEDURE_APPROVED_FG       BOOLEAN         NOT NULL COMMENT 'A flag indicating whether the customs procedure is approved.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CUSTOMS_PROCEDURE_APPROVE_STATUS PRIMARY KEY (CUSTOMS_PROCEDURE_APPROVE_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Defines the approvement status values of a customs procedure. - Source - Manual';
