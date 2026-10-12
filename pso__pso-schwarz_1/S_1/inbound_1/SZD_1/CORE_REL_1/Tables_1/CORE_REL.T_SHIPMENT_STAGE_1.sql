/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_STAGE_1
   generated from Powerdesigner on Montag, 19. Mai 2025 08:50:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SHIPMENT_STAGE_1 (
   SHIPMENT_STAGE_ID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the shipment stage.',
   SHIPMENT_STAGE_NAME                 VARCHAR(100)    NOT NULL COMMENT 'The name of the shipment stage.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_SHIPMENT_STAGE PRIMARY KEY (SHIPMENT_STAGE_ID) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Contains the possible stages of a shipment. - Source - Manual';
