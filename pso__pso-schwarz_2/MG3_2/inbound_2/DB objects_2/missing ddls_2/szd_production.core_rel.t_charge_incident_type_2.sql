CREATE OR REPLACE TABLE szd_production.core_rel.t_charge_incident_type_2 (
    charge_incident_type_id NUMBER(38,0) NOT NULL COMMENT 'the unique identifier of the charge incident type.',
    charge_incident_type_descr VARCHAR(250) NOT NULL COMMENT 'a brief description of the incident.',
    dwh_created_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was inserted into the table.',
    dwh_updated_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the point in time when this record was last modified. (in case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
    dwh_src_file_name VARCHAR(500) COMMENT 'contains the name(s) of the input file(s) that delivered the record. it can be either the full path of the blog storage or the shortened file path',
    dwh_src_1_tmsp TIMESTAMP_LTZ(9) NOT NULL COMMENT 'the extraction timestamp of the record from the source',
    CONSTRAINT pk_charge_incident_type PRIMARY KEY (charge_incident_type_id)
) COMMENT = 'minor entity - defines the possible types of incidents that can happen when charging a car. - source - iotcharger';