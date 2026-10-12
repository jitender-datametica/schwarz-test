/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_MILESTONE_RESULT_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_MILESTONE_RESULT_1 (
   LOT_MILESTONE_RESULT_CD             VARCHAR(50)     NOT NULL COMMENT 'A milestone is an event in the lot lifecycle. Table contains the list of the possible events',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_MILESTONE_RESULT PRIMARY KEY (LOT_MILESTONE_RESULT_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - A milestone is an event in the lot lifecycle. Table contains the list of the result of possible events.  -  Source - VMT';
