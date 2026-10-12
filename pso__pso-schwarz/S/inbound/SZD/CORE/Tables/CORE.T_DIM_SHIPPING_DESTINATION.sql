/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_SHIPPING_DESTINATION
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_SHIPPING_DESTINATION (
   SHIPPING_DESTINATION_CD             VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The code identifying a political country according to ISO 3166.',
   SHIPPING_DESTINATION_NAME           VARCHAR(100)    NOT NULL COMMENT 'The name for a political country in group language, i.e. in German.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_SHIPPING_DESTINATION PRIMARY KEY (SHIPPING_DESTINATION_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Shipping destination codes and their description in various languages. - Source - VMT';
