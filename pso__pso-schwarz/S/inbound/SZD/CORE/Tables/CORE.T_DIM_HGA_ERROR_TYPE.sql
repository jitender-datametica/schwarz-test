/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_HGA_ERROR_TYPE
   generated from Powerdesigner on Mittwoch, 15. Februar 2023 17:17:20
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_HGA_ERROR_TYPE (
   HGA_ERROR_TYPE_ID                   NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier for the hga error type',
   HGA_ERROR_TYPE_DESCR                VARCHAR(250)    NOT NULL COMMENT 'Name for the hga error type. Partial or total failure are possible values',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_DIM_HGA_ERROR_TYPE PRIMARY KEY (HGA_ERROR_TYPE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - for describing the different error types. Partial or total failure are possible values. Source - extracted from SPROD-File under machine/errors/type element.';

