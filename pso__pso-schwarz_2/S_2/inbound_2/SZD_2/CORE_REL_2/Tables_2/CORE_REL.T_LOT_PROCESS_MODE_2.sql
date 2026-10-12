/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_PROCESS_MODE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_PROCESS_MODE_2 (
   LOT_PROCESS_MODE_CD                 VARCHAR(50)     NOT NULL COMMENT 'Processing mode defines who handles the unloading and the transport to the country_2 distribution center. ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_PROCESS_MODE PRIMARY KEY (LOT_PROCESS_MODE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Processing mode defines who handles the unloading and the transport to the country_2 distribution center. When OWIM DWH is selected the container goes through the import warehouses. In other cases, the container is delivered directly to the specific countries - Source - VMT';
