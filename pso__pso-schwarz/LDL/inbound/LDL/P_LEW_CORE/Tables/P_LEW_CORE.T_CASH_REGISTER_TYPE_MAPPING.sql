/*
#-----------------------------------------------------------------------------
# History:
#  1.0     24.02.2023      Stephane Djiomou Tonga            Initial Version.
#
#-----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_CORE.T_CASH_REGISTER_TYPE_MAPPING (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the LIDL country. (see P_LEW_CORE.T_CLIENT)',
   register_id                         NUMBER(38,0)    NOT NULL COMMENT 'A register ID used in the LIDL country.',
   register_type_cd                    VARCHAR(100)    NOT NULL COMMENT 'The code for the type of the register identified by the ID and the LIDL country (e.g. SCO for Self Check Out, see P_LEW_CORE.T_REGISTER_TYPE).',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'The start date of the validity of the register type mapping.',
   dwh_valid_to                        DATE            COMMENT 'The end date of the validity of the register type mapping.',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'A flag indicating wether this entry is still present in the source system (0) or not (1).',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The ID identifying the loading process that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when this row was inserted in this table.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the last update occured to this row.',   
   CONSTRAINT PK_CASH_REGISTER_TYPE_MAPPING PRIMARY KEY (client_id, register_id) NOT ENFORCED 
)  COMMENT = 'This table contains a mapping between register IDs and types of registers like standard or self check out registers. The mapping depends on the LIDL country.';