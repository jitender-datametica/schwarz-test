/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_LOCALIZATION
   generated from Powerdesigner on Dienstag, 30. April 2024 14:55:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_LOCALIZATION (
   LOCALIZATION_ID                     NUMBER(38, 0)   NOT NULL COMMENT 'Natural Key/Business Key - code identifying the discriminators for localization',
   LOCALIZATION_NAME                   VARCHAR(100)    NOT NULL COMMENT 'A name for the discriminators for localization. E.g. for solution values like local, global, hybrid',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DIM_LOCALIZATION PRIMARY KEY (LOCALIZATION_ID) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Defines the discriminators for solution localization e.g. local, global, hybrid - Source - IT4You Service Now';
