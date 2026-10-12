/* --------------------------------------------------------------------------------
   DDL for table: T_RECEIPT_STATUS_1
   generated from Powerdesigner on Montag, 17. Juli 2023 11:08:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_RECEIPT_STATUS_1 (
   RECEIPT_STATUS_CD                   VARCHAR(250)    NOT NULL COMMENT 'Natural Key/Business Key - The unique code of the receipt status.',
   RECEIPT_STATUS_WWT_CD               VARCHAR(250)    NOT NULL COMMENT 'The identifier of the receipt status_1 from the WWT system.',
   RECEIPT_STATUS_NAME                 VARCHAR(100)    NOT NULL COMMENT 'Descriptive Attribute - The name of the receipt status.',
   RECEIPT_STATUS_DESCR                VARCHAR(250)    NOT NULL COMMENT 'Descriptive Attribute - A brief description of the receipt status.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    NOT NULL COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source.',   
   CONSTRAINT PK_RECEIPT_STATUS PRIMARY KEY (RECEIPT_STATUS_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Contains the possible status_1 values for an order position. - Source - Manual';
