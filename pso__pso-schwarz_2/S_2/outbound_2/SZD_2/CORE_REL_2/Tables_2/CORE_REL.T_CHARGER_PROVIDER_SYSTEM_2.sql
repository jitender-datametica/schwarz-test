/* --------------------------------------------------------------------------------
   DDL for table: T_CHARGER_PROVIDER_SYSTEM_2
   generated from Powerdesigner on Donnerstag, 9. November 2023 13:56:24
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_charger_provider_system_2 (
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='Natural/Business Key - The unique code of the charger provider system.'),
charger_provider_system_name STRING(100) NOT NULL
OPTIONS(description='The displayable name of the charger provider system.'),
charger_provider_system_descr STRING(250) NOT NULL
OPTIONS(description='A brief description of the charger provider system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (charger_provider_system_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - The charger provider system describes the source system where the charging information came from. - Source - Manual ');