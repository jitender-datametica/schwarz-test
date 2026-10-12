/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONTAINER_ISO_TYPE_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CONTAINER_ISO_TYPE_1 (
   CONTAINER_ISO_TYPE_CD               VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The type code for a container',
   CONTAINER_ISO_TYPE_DESCR            VARCHAR(250)    NOT NULL COMMENT 'A textual description for the status_1 code.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_CONTAINER_ISO_TYPE PRIMARY KEY (CONTAINER_ISO_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The minor dimension that contains the list of possible iso types of container. - Source - VMT';
