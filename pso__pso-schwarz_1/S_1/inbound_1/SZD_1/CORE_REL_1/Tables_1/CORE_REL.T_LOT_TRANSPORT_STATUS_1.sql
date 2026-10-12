/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_TRANSPORT_STATUS_1
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_TRANSPORT_STATUS_1 (
   LOT_TRANSPORT_STATUS_CD             VARCHAR(50)     NOT NULL COMMENT 'Status_1 of lot transport name (e.g. could be also delayed)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_TRANSPORT_STATUS PRIMARY KEY (LOT_TRANSPORT_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity -  Status_1 of lot transport (e.g. could be also delayed)  - Source - VMT';
