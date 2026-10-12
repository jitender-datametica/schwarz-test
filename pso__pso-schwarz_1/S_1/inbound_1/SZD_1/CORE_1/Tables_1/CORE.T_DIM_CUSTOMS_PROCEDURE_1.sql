/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CUSTOMS_PROCEDURE_1
   generated from Powerdesigner on Freitag, 19. Mai 2023 09:31:56
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CUSTOMS_PROCEDURE_1 (
   CUSTOMS_PROCEDURE_CD                VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the customs procedure.',
   REQUESTED_PROCEDURE_CD              VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of requested procedure.',
   REQUESTED_PROCEDURE_DESCR           VARCHAR(250)    NOT NULL COMMENT 'Denormalized Attribute - A brief description of the requested procedure code.',
   ADDITIONAL_PROCEDURE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the type of additional procedure.',
   ADDITIONAL_PROCEDURE_DESCR          VARCHAR(250)    NOT NULL COMMENT 'Denormalized Attribute - A brief description of the additional procedure code.',
   CUSTOMS_PROCEDURE_APPROVE_STATUS_CD VARCHAR(50)     COMMENT 'The unique code of the type of customs procedure approval status.',
   CUSTOMS_PROCEDURE_APPROVE_STATUS_NAME VARCHAR(100)    NOT NULL COMMENT 'Denormalized Attribute - The name of the type of the customs procedure approval status.',
   CUSTOMS_PROCEDURE_APPROVED_FG       BOOLEAN         NOT NULL COMMENT 'Denormalized Attribute - A flag indicating whether the customs procedure is approved.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_CUSTOMS_PROCEDURE PRIMARY KEY (CUSTOMS_PROCEDURE_CD) NOT ENFORCED 
)  COMMENT = 'Major Dimension - Contains all customs procedure codes used in a CDS item_1 report or in a Broker report - Source - CDS Item_1 Report, Broker Report, Manual';
