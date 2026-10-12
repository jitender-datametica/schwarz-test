/*
#-----------------------------------------------------------------------------
# History:
#  1.0     24.02.2023      Stephane Djiomou Tonga            Initial Version.
#
#-----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_cash_register_type_mapping_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The ID of the LIDL country. (see P_LEW_CORE.T_CLIENT_1)'),
register_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='A register ID used in the LIDL country.'),
register_type_cd STRING(100) NOT NULL
OPTIONS(description='The code for the type of the register identified by the ID and the LIDL country_1 (e.g. SCO for Self Check Out, see P_LEW_CORE.T_REGISTER_TYPE).'),
dwh_valid_from DATE NOT NULL OPTIONS(description='The start date of the validity_1 of the register type mapping.'),
dwh_valid_to DATE OPTIONS(description='The end date of the validity_1 of the register type mapping.'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='A flag indicating wether this entry is still present in the source system (0) or not (1).'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The ID identifying the loading process that inserted or updated this row.'),
dwh_created DATETIME NOT NULL OPTIONS(description='The timestamp when this row was inserted in this table.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='The timestamp when the last update occured to this row.'),
PRIMARY KEY (client_id, register_id) NOT ENFORCED
)
OPTIONS(description='This table contains a mapping between register IDs and types of registers like standard or self check out registers. The mapping depends on the LIDL country.');