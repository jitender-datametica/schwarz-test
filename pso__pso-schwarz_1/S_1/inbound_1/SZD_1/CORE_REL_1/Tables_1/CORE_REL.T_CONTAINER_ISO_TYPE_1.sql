/* --------------------------------------------------------------------------------
   DDL for table: T_CONTAINER_ISO_TYPE_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_CONTAINER_ISO_TYPE_1 (
   CONTAINER_ISO_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'The type code that define a container like "22G0", "42G0" or "42R1" and others',
   CONTAINER_ISO_TYPE_DESCR            VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - A textual description of the type of container',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_CONTAINER_ISO_TYPE PRIMARY KEY (CONTAINER_ISO_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity -The minor dimension that contains the list of iso types of a container - Source - VMT';
