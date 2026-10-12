/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_PACKING_PLACE_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONTAINER_PACKING_PLACE_1 (
   CONTAINER_PACKING_PLACE_CD          VARCHAR(50)     NOT NULL COMMENT 'Information where the container stuffing takes place ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_CONTAINER_PACKING_PLACE PRIMARY KEY (CONTAINER_PACKING_PLACE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity -Table contains the information where the container stuffing is taken place ( at the factory or at an export warehouse (CFS / IC) in Asia )  - Source - VMT';
