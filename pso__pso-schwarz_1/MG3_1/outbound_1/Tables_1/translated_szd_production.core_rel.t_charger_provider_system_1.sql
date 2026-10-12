CREATE OR REPLACE TABLE szd_production_core_rel.t_charger_provider_system_1 (
charger_provider_system_cd STRING(50) NOT NULL
OPTIONS(description='natural/business key - the unique code of the charger provider system.'),
charger_provider_system_name STRING(100) NOT NULL
OPTIONS(description='the displayable name of the charger provider system.'),
charger_provider_system_descr STRING(250) NOT NULL
OPTIONS(description='a brief description of the charger provider system.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the extraction timestamp of the record from the source'),
PRIMARY KEY (charger_provider_system_cd) NOT ENFORCED
)
OPTIONS(description='minor entity - the charger provider system describes the source system where the charging information came from. - source - manual');