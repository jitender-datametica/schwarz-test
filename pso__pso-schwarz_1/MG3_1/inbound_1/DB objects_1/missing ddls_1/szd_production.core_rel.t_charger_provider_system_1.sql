CREATE OR REPLACE TABLE szd_production.core_rel.t_charger_provider_system_1 (
    charger_provider_system_cd VARCHAR(50) NOT NULL COMMENT 'natural/business key - the unique code of the charger provider system.',
    charger_provider_system_name VARCHAR(100) NOT NULL COMMENT 'the displayable name of the charger provider system.',
    charger_provider_system_descr VARCHAR(250) NOT NULL COMMENT 'a brief description of the charger provider system.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
    dwh_src_file_name VARCHAR(500) COMMENT 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blob storage or the shortened file path',
    dwh_src_1_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the extraction timestamp of the record from the source',
    CONSTRAINT pk_charger_provider_system PRIMARY KEY (charger_provider_system_cd)
) 
COMMENT = 'minor entity - the charger provider system describes the source system where the charging information came from. - source - manual';