/*
#-----------------------------------------------------------------------------
# History:
#  1.0     24.02.2023      Stephane Djiomou Tonga            Initial Version.
#
#-----------------------------------------------------------------------------
*/

CREATE TABLE P_LEW_CORE.T_CASH_REGISTER_TYPE_2 (
   register_type_cd                    VARCHAR(100)    NOT NULL COMMENT 'The code identifying this register type.',
   register_type_name                  VARCHAR(100)    NOT NULL COMMENT 'The name of this register type.',
   register_type_descr                 VARCHAR(1000)   COMMENT 'A brief description of the register type.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The ID identifying the loading process that inserted or updated this row.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when this row was inserted in this table.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'The timestamp when the last update occured to this row.',   
   CONSTRAINT PK_CASH_REGISTER_TYPE PRIMARY KEY (register_type_cd) NOT ENFORCED 
)  COMMENT = 'This table contains the possible types a register can be categorized with.';