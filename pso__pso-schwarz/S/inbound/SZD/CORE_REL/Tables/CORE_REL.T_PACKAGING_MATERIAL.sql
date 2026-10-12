/* --------------------------------------------------------------------------------
   DDL for table: T_PACKAGING_MATERIAL
   generated from Powerdesigner on Freitag, 9. Mai 2025 15:14:31
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PACKAGING_MATERIAL (
   PACKAGING_MATERIAL_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the packaging material as used in the source system.',
   PACKAGING_MATERIAL_NAME             VARCHAR(100)    NOT NULL COMMENT 'The name of the packaging material.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_PACKAGING_MATERIAL PRIMARY KEY (PACKAGING_MATERIAL_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the different types of packaging materials used in logistics and warehouse operations.';
