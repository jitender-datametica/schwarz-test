/* --------------------------------------------------------------------------------
   DDL for table: T_CHANNEL_KEY_2
   generated from Powerdesigner on Montag, 27. November 2023 10:12:40
*/ --------------------------------------------------------------------------------

CREATE TABLE META.T_CHANNEL_KEY_2 (
   CHANNEL_SID                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the channel',
   CHANNEL_KEY_TYPE_CD                 VARCHAR(50)     NOT NULL COMMENT 'The code for the type of natural key which identifies the agreement.',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   CHANNEL_NAT_KEY_NR                  VARCHAR(250)    NOT NULL COMMENT 'The natural key which identifies the channel. In case the natural key consist of several columns, all components get concatenated.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',   
   CONSTRAINT PK_T_CHANNEL_KEY PRIMARY KEY (CHANNEL_KEY_TYPE_CD, DWH_VALID_FROM_TMSP, CHANNEL_NAT_KEY_NR) NOT ENFORCED 
)  COMMENT = 'Metadata - Keytable - Channel - Contains the mapping between surrogate keys and natural keys for business objects from the subject area "Channel ".';
