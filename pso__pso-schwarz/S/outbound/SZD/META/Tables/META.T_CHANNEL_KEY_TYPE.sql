/* --------------------------------------------------------------------------------
   DDL for table: T_CHANNEL_KEY_TYPE
   generated from Powerdesigner on Donnerstag, 16. November 2023 08:59:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_meta.t_channel_key_type (
channel_key_type_cd STRING(50) NOT NULL
OPTIONS(description='The code for the type of natural key which identifies the agreement.'),
channel_key_type_name STRING(100) NOT NULL
OPTIONS(description='The name of the type of natural key which identifies the agreement.'),
channel_key_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the type of natural key, detailing its format and the meaning of the components.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
PRIMARY KEY (channel_key_type_cd) NOT ENFORCED
)
OPTIONS(description='Metadata - Keytable - Channel - Contains the types that shares the key space for the subject area "Channel".');