/*
#-----------------------------------------------------------------------------
# History:
#  1.0     24.02.2023      Stephane Djiomou Tonga            Initial Version.
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cash_register_type_2 (
register_type_cd STRING(100) NOT NULL OPTIONS(description='The code identifying this register type.'),
register_type_name STRING(100) NOT NULL OPTIONS(description='The name of this register type.'),
register_type_descr STRING(1000) OPTIONS(description='A brief description of the register type.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID identifying the loading process that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when this row was inserted in this table.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the last update occured to this row.'),
PRIMARY KEY (register_type_cd) NOT ENFORCED
) OPTIONS(description='This table contains the possible types a register can be categorized with.');