/* --------------------------------------------------------------------------------
   DDL for table: T_CHANNEL_KEY_TYPE_1
   generated from Powerdesigner on Donnerstag, 16. November 2023 08:59:50
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_CHANNEL_KEY_TYPE_1 (
   CHANNEL_KEY_TYPE_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the agreement.',
   CHANNEL_KEY_TYPE_NAME               VARCHAR(100)    NOT NULL COMMENT 'The name of the type of natural key which identifies the agreement.',
   CHANNEL_KEY_TYPE_DESCR              VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of natural key, detailing its format and the meaning of the components.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_CHANNEL_KEY_TYPE PRIMARY KEY (CHANNEL_KEY_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Channel - Contains the types that shares the key space for the subject area "Channel".';
