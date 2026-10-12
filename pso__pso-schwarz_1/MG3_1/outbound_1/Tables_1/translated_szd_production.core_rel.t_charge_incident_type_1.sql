CREATE OR REPLACE TABLE szd_production_core_rel.t_charge_incident_type_1 (
charge_incident_type_id INTEGER NOT NULL OPTIONS(description='the unique identifier of the charge incident type.'),
charge_incident_type_descr STRING(250) NOT NULL OPTIONS(description='a brief description of the incident.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='the extraction timestamp of the record from the source'),
PRIMARY KEY (charge_incident_type_id) NOT ENFORCED
)
OPTIONS(description='minor entity - defines the possible types of incidents that can happen when charging a car. - source - iotcharger');