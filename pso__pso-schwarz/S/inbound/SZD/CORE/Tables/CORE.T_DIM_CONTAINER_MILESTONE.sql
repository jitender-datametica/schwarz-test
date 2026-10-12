/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_CONTAINER_MILESTONE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_CONTAINER_MILESTONE (
   CONTAINER_MILESTONE_CD              VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - A milestone is an event in the container lifecycle. Table contains the list of the possible events',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_CONTAINER_MILESTONE PRIMARY KEY (CONTAINER_MILESTONE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - A milestone is an event in the container lifecycle. Table contains the list of the possible events. - Source - VMT';
