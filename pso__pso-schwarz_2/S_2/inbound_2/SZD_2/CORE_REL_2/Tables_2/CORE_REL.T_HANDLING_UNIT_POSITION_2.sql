/* --------------------------------------------------------------------------------
   DDL for table: T_HANDLING_UNIT_POSITION_2
   generated from Powerdesigner on Montag, 12. Mai 2025 13:26:58
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_HANDLING_UNIT_POSITION_2 (
   INTERNAL_HANDLING_UNIT_NR           VARCHAR(250)    NOT NULL COMMENT 'Business / Natural Key - The unique identification number of the handling unit.',
   INTERNAL_HANDLING_UNIT_POS_NR       NUMBER(38, 0)   NOT NULL COMMENT 'Business / Natural Key - The position number within the handling unit.',
   INTERNAL_MATERIAL_POSITION_NR       VARCHAR(250)    NOT NULL COMMENT 'Business / Natural Key - The unique identification of the material position number.',
   PRODUCT_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the product variant.',
   PACKAGING_MATERIAL_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the packaging material as used in the source system.',
   PACKAGED_BASE_QTY                   NUMBER(38, 5)   NOT NULL COMMENT 'The packaged base quantity for this handling unit_2 position.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_HANDLING_UNIT_POSITION PRIMARY KEY (INTERNAL_HANDLING_UNIT_NR, INTERNAL_HANDLING_UNIT_POS_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Represents individual items packed within a handling unit.';
