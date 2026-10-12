/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_PORT_PRICE_GROUP
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_PORT_PRICE_GROUP (
   PORT_PRICE_GROUP_CD                 VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code for the price group ',
   PORT_PRICE_GROUP_DESCR              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the price group ',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_PORT_PRICE_GROUP PRIMARY KEY (PORT_PRICE_GROUP_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - The minor dimension that contains price group used for invoicing purposes. - Source - VMT';
