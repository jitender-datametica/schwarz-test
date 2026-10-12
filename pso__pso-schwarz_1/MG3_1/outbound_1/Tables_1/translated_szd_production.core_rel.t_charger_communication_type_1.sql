CREATE OR REPLACE TABLE szd_production_core_rel.t_charger_communication_type_1 (
charger_communication_type_id INTEGER NOT NULL
OPTIONS(description='the unique code of the communication_1 type of a charger.'),
charger_communication_type_name STRING(100) NOT NULL
OPTIONS(description='the technical name of the communication_1 type.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the extraction timestamp of the record from the source'),
PRIMARY KEY (charger_communication_type_id) NOT ENFORCED
)
OPTIONS(description='minor entity - defines the possible types/protocols that are used by the charger to communicate. - source - manual');