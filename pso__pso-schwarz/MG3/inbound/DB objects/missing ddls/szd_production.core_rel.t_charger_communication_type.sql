CREATE OR REPLACE TABLE szd_production.core_rel.t_charger_communication_type (
    charger_communication_type_id NUMBER(38,0) NOT NULL COMMENT 'the unique code of the communication type of a charger.',
    charger_communication_type_name VARCHAR(100) NOT NULL COMMENT 'the technical name of the communication type.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
    dwh_src_file_name VARCHAR(500) COMMENT 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blob storage or the shortened file path',
    dwh_src_1_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the extraction timestamp of the record from the source',
    CONSTRAINT pk_charger_communication_type PRIMARY KEY (charger_communication_type_id)
) 
COMMENT = 'minor entity - defines the possible types/protocols that are used by the charger to communicate. - source - manual';