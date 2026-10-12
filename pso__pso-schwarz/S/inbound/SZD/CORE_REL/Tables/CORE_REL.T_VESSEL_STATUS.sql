/* --------------------------------------------------------------------------------
   DDL for table: T_VESSEL_STATUS
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_VESSEL_STATUS (
   VESSEL_STATUS_CD                    VARCHAR(50)     NOT NULL COMMENT 'The status code for the vessel ',
   VESSEL_STATUS_DESCR                 VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - A textual description for the status code  written out in group language (German).',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_VESSEL_STATUS PRIMARY KEY (VESSEL_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The minor dimension that contains the list of possible values for vessel status - Source - VMT';
